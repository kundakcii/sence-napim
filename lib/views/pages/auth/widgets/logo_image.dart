import 'package:flutter/material.dart';
import 'package:sence/helpers/windows_size.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);
  final String logoPath = 'assets/images/logo.png';
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoPath,
      height: WindowsSize(context: context).screenHeight(percent: 0.5),
    );
  }
}
