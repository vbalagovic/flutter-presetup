import 'package:presetup/firebase_options_prod.dart';
import 'package:presetup/flavor_config.dart';
import 'package:presetup/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    env: "prod",
    name: "FlutterPresetup",
    values: FlavorValues(
        bundleID: 'app.example.presetup',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
