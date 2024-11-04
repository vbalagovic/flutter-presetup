import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:presetup/data/providers/auth_provider.dart';
import 'package:presetup/data/providers/theme_provider.dart';
import 'package:presetup/flavor_banner.dart';
// BEGIN REMOVE MOBILE ADS
import 'package:presetup/widgets/ads/banner_ad_block.dart';
import 'package:presetup/widgets/ads/native_ad_block.dart';
import 'package:presetup/widgets/ads/reward_ad_block.dart';
// END REMOVE MOBILE ADS

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  void getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });

    await FirebaseAnalytics.instance.logEvent(
      name: 'Dashboard Screen seen',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(title: const Text("Dashboard").tr(), actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(signInProvider.notifier).signOut();
            },
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("App Name: $appName"),
              Text("packageName: $packageName"),
              Text("version: $version"),
              Text("buildNumber: $buildNumber"),
              const Divider(),
              // BEGIN REMOVE MOBILE ADS
              const Text(
                "Banner Ad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Padding(
                  padding: EdgeInsets.all(20), child: BannerAdBlock()),
              const Text(
                "Native Ad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Padding(
                  padding: EdgeInsets.all(20), child: NativeAdBlock()),
              const Text(
                "Rewarded Inter. Ad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Padding(
                  padding: EdgeInsets.all(20), child: RewardAdBlock()),

              // END REMOVE MOBILE ADS
              const Divider(),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                title: const Text("Dark Theme"),
                trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) async {
                      if (Theme.of(context).brightness == Brightness.light) {
                        ref
                            .read(themeProvider.notifier)
                            .setThemeMode(ThemeMode.dark);
                      } else {
                        ref
                            .read(themeProvider.notifier)
                            .setThemeMode(ThemeMode.light);
                      }
                      //await EvaTheme.initialize();
                    }),
              ),
            ],
          )),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
