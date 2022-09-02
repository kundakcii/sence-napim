import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    required this.onpress,
    required this.text,
    Key? key,
  }) : super(key: key);
  final onpress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        onPressed: onpress,
        child: Text(
          text,
          style: const TextStyle(color: AppColors.BERRY_BLUE_GREEN),
        ),
      ),
    );
  }
}
