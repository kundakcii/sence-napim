import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/windows_size.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.labelText,
    required this.controller,
    Key? key,
  }) : super(key: key);
  TextEditingController controller;
  String labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.BERRY_BLUE_GREEN,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: AppColors.BERRY_BLUE_GREEN,
        ),
        labelText: labelText,
        contentPadding: EdgeInsets.all(
          WindowsSize(context: context).screenHeight(percent: 0.033),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.BERRY_BLUE_GREEN),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.BERRY_BLUE_GREEN),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
