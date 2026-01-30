import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
// BEGIN REMOVE MOBILE ADS
import 'package:google_mobile_ads/google_mobile_ads.dart';
// END REMOVE MOBILE ADS
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/data/providers/theme_provider.dart';
import 'package:presetup/services/push_notif_service.dart';
import 'package:presetup/utilities/router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:presetup/utilities/theme.dart';

void mainCommon(options) async {
  WidgetsFlutterBinding.ensureInitialized();
  // BEGIN REMOVE MOBILE ADS
  MobileAds.instance.initialize();
  // END REMOVE MOBILE ADS
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: options);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final pushNotifService = PushNotificationsService();

  if (Platform.isIOS) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await pushNotifService.registerNotification();
    });
  } else {
    await pushNotifService.registerNotification();
  }

  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final container = ProviderContainer();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    ),
  );
}

void configLoading() {}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = FpTheme.of(context).darkTone60
      ..backgroundColor = Colors.grey[50]
      ..contentPadding = const EdgeInsets.all(25)
      ..maskColor = Colors.transparent
      ..progressColor = FpTheme.of(context).darkTone60
      ..indicatorColor = FpTheme.of(context).darkTone60
      ..indicatorType = EasyLoadingIndicatorType.wave;

    final router = ref.watch(routerProvider);
    ThemeMode themeMode = ref.watch(themeProvider).mode;

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
      builder: EasyLoading.init(
        builder: (context, child) {
          //EasyLoading.init();
          // Obtain the current media query information.
          final mediaQueryData = MediaQuery.of(context);

          return MediaQuery(
            // Set the default textScaleFactor to 1.0 for
            // the whole subtree.
            data: mediaQueryData.copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}
