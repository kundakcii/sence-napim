import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sence/helpers/height_spacer.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/services/admob_service.dart';
import 'package:sence/services/answer_service.dart';
import 'package:sence/views/widgets/custom_button.dart';
import 'package:sence/views/widgets/custom_dvider.dart';
import 'package:sence/views/widgets/custom_textfield.dart';
import 'package:sence/views/widgets/custom_white_logo.dart';
import 'package:sence/views/widgets/show_custom_dialog.dart';

class GiveAnswerDetailPage extends StatefulWidget {
  const GiveAnswerDetailPage({super.key});

  @override
  State<GiveAnswerDetailPage> createState() => _GiveAnswerDetailPageState();
}

class _GiveAnswerDetailPageState extends State<GiveAnswerDetailPage> {
  TextEditingController? _controller;
  AnswerService? _answerService;
  final String _baseUrl = 'https://sence-napim.herokuapp.com/answer';
  var arguments;
  bool state = true;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _answerService = AnswerService(dio);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
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

  void addAnswer(
      {required String questionId,
      required String userId,
      required BuildContext context}) async {
    _showInterstitialAd();
    if (_controller!.text != '') {
      var response = await _answerService!.fetchAddAnswer(
        content: _controller!.text,
        questionId: questionId,
        owner: userId,
      );
      if (response != null) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Başarılı'),
            content: Text('Cevabınız başarıyla gönderildi.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  navigate();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Hata'),
            content: Text('lütfen tekrar deneyiniz'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  navigate();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  navigate() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/navigation',
      ModalRoute.withName('/navigation'),
    );
  }

  void showCustomDialog() {
    ShowCustomDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        title: const CustomWhiteLogo(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    arguments['content'].toString(),
                  ),
                  const Divider()
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      CustomTextField(
                          controller: _controller, labelText: 'Cevapla'),
                      const HeightSpacer(height: 0.02),
                      Consumer(
                        builder: (context, AuthProvider value, child) =>
                            CustomButton(
                                onPressed: () => addAnswer(
                                      context: context,
                                      questionId: arguments['_id'],
                                      userId: value.userId,
                                    ),
                                text: 'Bence'),
                      ),
                      const CustomDvider(),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
