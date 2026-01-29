import 'dart:developer';
import 'dart:io';

import './local_notif_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
}

class PushNotificationsService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //late GlobalKey<NavigatorState> navigatorKey;
  Future<void> registerNotification() async {
    //await Firebase.initializeApp();
    // Instantiate Firebase Messaging

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission first (this is required before getting token on iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    NotificationService().setupLocalNotif();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');

      // Only try to get token after permission is granted
      await initiateToken();

      setupInteractedMessage();
    } else {
      log('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification!.title}');
        sendNotif(message);
      }
    });

    log("setup interacted message");
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    log("initial message, $initialMessage");
    if (initialMessage != null) {
      // _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void sendNotif(RemoteMessage notificationMessage) async {
    await NotificationService().showNotification(
        notificationMessage.notification!.title,
        notificationMessage.notification!.body);
  }

  Future<String?> initiateToken() async {
    try {
      // On iOS, we need to wait for APNS token before getting FCM token
      if (Platform.isIOS) {
        // Check if APNS token is available (won't be on simulator)
        String? apnsToken = await messaging.getAPNSToken();
        if (apnsToken == null) {
          log("APNS token not available (running on simulator or APNS not configured)");
          // On simulator or without APNS, we can't get FCM token - this is expected
          return null;
        }
      }

      // Get the token each time the application loads
      String? token = await messaging.getToken();
      log("TOKEN $token");

      if (token != null) {
        final localStorage = await SharedPreferences.getInstance();
        localStorage.setString('fcm_token', token);
        await saveTokenToDatabase(token);

        // Any time the token refreshes, store this in the database too.
        messaging.onTokenRefresh.listen(saveTokenToDatabase);
      }

      return token;
    } catch (e) {
      log("Error getting FCM token: $e");
      // This is expected on iOS simulator - push notifications won't work there
      return null;
    }
  }

  Future<bool> saveTokenToDatabase(token) async {
    //return await UserService().updateFCMToken(token);
    return true;
  }
}
