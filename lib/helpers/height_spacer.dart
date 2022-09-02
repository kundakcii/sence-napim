import 'package:flutter/material.dart';
import 'package:sence/helpers/windows_size.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({required this.height, super.key});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WindowsSize(context: context).screenHeight(percent: height),
    );
  }
}
