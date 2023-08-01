import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:presetup/widgets/fp_button.dart';
import '../../utilities/ad_helper.dart';

class RewardAdBlock extends ConsumerStatefulWidget {
  const RewardAdBlock({super.key});

  @override
  ConsumerState<RewardAdBlock> createState() => _RewardAdBlockState();
}

class _RewardAdBlockState extends ConsumerState<RewardAdBlock> {
  RewardedInterstitialAd? _rewardedInterstitialAd;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      createRewardAdBlock();
    });
  }

  @override
  void dispose() {
    _rewardedInterstitialAd?.dispose();

    super.dispose();
  }

  void createRewardAdBlock() {
    RewardedInterstitialAd.load(
        adUnitId: AdHelper.rewardedInterstitialAdUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _rewardedInterstitialAd = ad;
            setState(() {});
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showAd() {
    if (_rewardedInterstitialAd != null) {
      _rewardedInterstitialAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        log("reward item ---- $rewardItem");
        log("reward item amount ---- ${rewardItem.amount}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _rewardedInterstitialAd != null
        ? FpButton(
            title: "Show reward ad",
            onPressed: () {
              showAd();
            },
          )
        : Container(
            child: const Text("Add not loaded"),
          );
  }
}
