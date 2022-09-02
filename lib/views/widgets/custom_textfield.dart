import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/windows_size.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required TextEditingController? controller,
    required String? labelText,
  })  : _controller = controller,
        _labelText = labelText,
        super(key: key);

  final TextEditingController? _controller;
  final String? _labelText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      minLines: 5,
      maxLines: null,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: AppColors.BERRY_BLUE_GREEN,
        ),
        labelText: _labelText,
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
