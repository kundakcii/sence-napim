import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/height_spacer.dart';
import 'package:sence/helpers/secure_store_service.dart';
import 'package:sence/helpers/windows_size.dart';
import 'package:sence/models/question_model/question_model.dart';
import 'package:sence/services/admob_service.dart';
import 'package:sence/services/question_service.dart';
import 'package:sence/views/widgets/custom_textfield.dart';
import 'package:sence/views/widgets/show_custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _controller;
  QuestionService? _questionService;
  final _baseUrl = 'https://sence-napim.herokuapp.com/question';
  late SecureStoreService _secureStoreService;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _controller = TextEditingController();
    _questionService = QuestionService(dio);
    _secureStoreService = SecureStoreService();
    _createInterstitialAd();
    _createRewardedAd();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => setState(() {
            _rewardedAd = ad;
          }),
          onAdFailedToLoad: (error) => setState(() {
            _rewardedAd = null;
          }),
        ));
  }

  _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: ((ad, error) {
          ad.dispose();
          _createRewardedAd();
        }),
      );
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          setState(() {});
        },
      );
      _rewardedAd = null;
    }
  }

  _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) => _interstitialAd = ad,
            onAdFailedToLoad: (LoadAdError err) => _interstitialAd = null));
  }

  _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) =>
              print('Ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            _createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent:
              (InterstitialAd ad, AdError error) {
            print('Ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            _createInterstitialAd();
          });
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void senceNapimButton() async {
    _showInterstitialAd();
    var id = await _secureStoreService.readValue(key: 'id');
    showCustomDialog();
    if (_controller!.text != '' && id != null) {
      var response = await _questionService!.fetchAddQuestion(
          QuestionModel(content: _controller!.text, owner: id));
      if (response != null) {
        Future.delayed(const Duration(seconds: 1), () {
          ShowCustomDialog.showAlert(
            context: context,
            content: 'Sorunuz aktif 5 kişiye gönderiliyor...',
            title: 'Başarılı',
          );
        });
        _controller!.clear();
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          ShowCustomDialog.showAlert(
            context: context,
            content: 'lütfen tekrar deneyiniz',
            title: 'Hata',
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        ShowCustomDialog.showAlert(
          context: context,
          content: 'lütfen tekrar deneyiniz',
          title: 'Hata',
        );
      });
    }
    navigate();
  }

  navigate() {
    Navigator.pop(context);
  }

  void showCustomDialog() {
    ShowCustomDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _controller,
              labelText: 'Merakını gider...',
            ),
            const HeightSpacer(height: 0.1),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(
                    WindowsSize(context: context).screenHeight(percent: 0.030)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                side: const BorderSide(
                    width: 1, color: AppColors.BERRY_BLUE_GREEN),
              ),
              onPressed: senceNapimButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.question_mark_outlined,
                    color: AppColors.BERRY_BLUE_GREEN,
                  ),
                  Text(
                    'sencenapim',
                    style: TextStyle(color: AppColors.BERRY_BLUE_GREEN),
                  ),
                  Icon(
                    Icons.question_mark_outlined,
                    color: AppColors.BERRY_BLUE_GREEN,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
