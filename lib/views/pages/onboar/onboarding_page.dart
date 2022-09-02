import 'package:flutter/material.dart';
import 'package:sence/constants/onboard_data.dart';
import 'package:sence/views/pages/onboar/widgets/custom_onboard.dart';
import 'package:sence/views/pages/onboar/widgets/dot_widget.dart';
import 'package:sence/views/pages/onboar/widgets/onboarding_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _pageIndex = 0;
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void nextPage() {
    if (_pageController!.page == 3) {
      Navigator.pushReplacementNamed(context, '/login');
    }
    _pageController!.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void lastPage() {
    _pageController!.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _pageIndex = value;
                  });
                },
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CustomOnboard(
                    image: data[index].image,
                    title: data[index].title,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pageIndex == 0
                    ? Container()
                    : OnboardingButton(
                        onpress: lastPage,
                        text: 'geri',
                      ),
                ...List.generate(
                  data.length,
                  (index) => Dot(isActive: index == _pageIndex),
                ),
                OnboardingButton(
                  onpress: nextPage,
                  text: _pageIndex == 3 ? 'Geç' : 'ileri',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
