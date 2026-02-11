
import 'dart:io';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;

  final adUnitId = Platform.isAndroid
      ? dotenv.get('ANDROID_AD_ID', fallback: '')
      : dotenv.get('IOS_AD_ID', fallback: '');

  void loadAd() {
    if (_interstitialAd != null) {
      return;
    }
    if (Random().nextInt(3) != 0) {
      return;
    }

    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
          },
        ));
  }

  void showAd() {
    _interstitialAd?.show();
  }
}