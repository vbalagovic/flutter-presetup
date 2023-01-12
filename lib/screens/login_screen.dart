import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:presetup/flavor_banner.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
            child: Column(
          children: [
            Text("App Name: $appName"),
            Text("packageName: $packageName"),
            Text("version: $version"),
            Text("buildNumber: $buildNumber"),
          ],
        )), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
