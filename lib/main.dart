import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kvizio/data/providers/theme_provider.dart';
import 'package:kvizio/utilities/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
