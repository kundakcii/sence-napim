import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';

class CustomFooter extends StatelessWidget {
  CustomFooter({
    required this.text,
    required this.textButton,
    required this.routeText,
    Key? key,
  }) : super(key: key);
  String text;
  String textButton;
  String routeText;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: AppColors.BERRY_BLUE_GREEN,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, routeText);
              },
            text: textButton,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.BERRY_BLUE_GREEN,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
