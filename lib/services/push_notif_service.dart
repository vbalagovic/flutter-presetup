import 'dart:developer';

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

    await initiateToken();

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
    // Get the token each time the application loads
    String? token = await messaging.getToken();
    log("TOKEN $token");
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('fcm_token', token.toString());
    await saveTokenToDatabase(token);

    // Any time the token refreshes, store this in the database too.
    messaging.onTokenRefresh.listen(saveTokenToDatabase);
    return token;
  }

  Future<bool> saveTokenToDatabase(token) async {
    //return await UserService().updateFCMToken(token);
    return true;
  }
}
