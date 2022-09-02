import 'package:flutter/material.dart';

class CustomWhiteLogo extends StatelessWidget {
  const CustomWhiteLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/white-logo.png',
      height: 50,
    );
  }
}
