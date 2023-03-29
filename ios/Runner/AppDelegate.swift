import UIKit
import Flutter

import google_mobile_ads

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)

      let listTileFactory = ListTileNativeAdFactory()
      FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
          self, factoryId: "listTile", nativeAdFactory: listTileFactory)

    // TODO: You can add test devices
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "e3e7e04c3f28fae5ad995f71016792cc" ]


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
