

import 'package:presetup/flavor_config.dart';
import 'package:presetup/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    env: "dev",
    name: "DEV FlutterPresetup",
    values: FlavorValues(
      bundleID: 'com.example.presetup.dev',
      appID: '',
      baseUrl: '',
      apiUrl: '',
      sentryUrl: '',
      dynamicLinkUrl: ''
    ),
  );

  mainCommon();
}
