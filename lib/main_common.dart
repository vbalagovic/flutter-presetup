import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:presetup/data/providers/theme_provider.dart';
import 'package:presetup/utilities/router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void mainCommon(options) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: options,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(EasyLocalization(supportedLocales: const [
    Locale('en'),
  ], path: 'assets/translations', fallbackLocale: const Locale('en'), child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.watch(themeProvider).mode;

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
