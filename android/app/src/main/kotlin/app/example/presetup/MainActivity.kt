package app.example.presetup

import io.flutter.embedding.android.FlutterActivity

// COMPLETE: Import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngine

// BEGIN REMOVE MOBILE ADS
// COMPLETE: Import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
// import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
// END REMOVE MOBILE ADS
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // BEGIN REMOVE MOBILE ADS
        // GoogleMobileAdsPlugin.registerNativeAdFactory(
        //         flutterEngine, "listTile", ListTileNativeAdFactory(context))
        // END REMOVE MOBILE ADS
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // BEGIN REMOVE MOBILE ADS
        // GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
        // END REMOVE MOBILE ADS
    }
}
