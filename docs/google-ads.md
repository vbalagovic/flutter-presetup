# Google Ads

#### Setup admob

* First, you need to create an admob account
* Create iOS and android applications and get ad mob id in the admob app settings
* Run script to add this ad mob id-s everywhere where needed

```
sh setup_admob_credentials.sh
```

After running this script all 3 types of ads should be working.

There are three examples of apps so you can create them and update `ad_helper.dart`with the correct id per type of app. Current values are test ids so you can use them for test purposes.

**Banner Ads**

Create banner add and update `ad_helper.dart` file `bannerAdUnitId` variable, link to banner ad if you have some issues [Banner ad](https://developers.google.com/admob/flutter/banner/get-started)

**Rewarded Interstitial As**

Create banner add and update `ad_helper.dart` file `rewardedInterstitialAdUnitId` variable, link to reward int. ad if you have some issues [Rewarded Interstitial ad](https://developers.google.com/admob/flutter/rewarded-interstitial)

**Native Ads**

There is an example of a native list ad. Design can be changed in `list_tile_native_ad.xml` file for android & `ListTileNativeAdView.xib` for iOS. For any updates check the article about native ads in a flutter. [Native Ads](https://medium.com/itnext/flutter-native-ads-92d802fbd927)
