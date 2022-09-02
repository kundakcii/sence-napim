import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/windows_size.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);
  String text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(
              WindowsSize(context: context).screenHeight(percent: 0.038)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          side: const BorderSide(width: 1, color: AppColors.BERRY_BLUE_GREEN),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.BERRY_BLUE_GREEN,
          ),
        ),
      ),
    );
  }
}
