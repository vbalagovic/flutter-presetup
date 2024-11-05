import UIKit
import Flutter

/* BEGIN REMOVE MOBILE ADS */
import google_mobile_ads
/* END REMOVE MOBILE ADS */

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)

    /* BEGIN REMOVE MOBILE ADS */
      let listTileFactory = ListTileNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self, factoryId: "listTile", nativeAdFactory: listTileFactory)

    // TODO: You can add test devices
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "e3e7e04c3f28fae5ad995f71016792cc" ]
    /* END REMOVE MOBILE ADS */

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
