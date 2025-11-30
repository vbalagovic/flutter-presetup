import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../utilities/ad_helper.dart';

class BannerAdBlock extends ConsumerStatefulWidget {
  const BannerAdBlock({super.key});

  @override
  ConsumerState<BannerAdBlock> createState() => _BannerAdBlockState();
}

class _BannerAdBlockState extends ConsumerState<BannerAdBlock> {
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      createBannerAdBlock();
    });
  }

  @override
  void dispose() {
    _ad?.dispose();

    super.dispose();
  }

  void createBannerAdBlock() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          log('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null
        ? Container(
            height: 55.0,
            alignment: Alignment.center,
            child: AdWidget(ad: _ad!),
          )
        : Container();
  }
}
