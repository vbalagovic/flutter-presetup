import '../../utilities/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdBlock extends StatefulWidget {
  const NativeAdBlock({super.key});

  @override
  State<NativeAdBlock> createState() => _NativeAdBlockState();
}

class _NativeAdBlockState extends State<NativeAdBlock> {
  // TODO: Add a native ad instance
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    debugPrint("*************** INIT STATE ***************");
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var add = ad as NativeAd;
          debugPrint("**** AD ***** ${add.responseInfo}");
          setState(() {
            _ad = add;
            isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => debugPrint('Ad clicked.'),
      ),
    );

    _ad!.load();
  }

  @override
  void dispose() {
    debugPrint("*********** DISPOSING **********");
    // TODO: Dispose a NativeAd object
    _ad?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null && isAdLoaded
        ? Container(
            height: 55.0,
            alignment: Alignment.center,
            child: AdWidget(ad: _ad!),
          )
        : Container(
            height: 55,
          );
  }
}
