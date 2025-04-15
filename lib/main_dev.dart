import 'package:presetup/flavor_config.dart';
import 'package:presetup/main_common.dart';
import 'firebase_options_dev.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    env: "dev",
    name: "DEV FlutterPresetup",
    values: FlavorValues(
        bundleID: 'app.example.presetup.dev',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
