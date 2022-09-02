import 'package:flutter/material.dart';

class WindowsSize {
  BuildContext? context;
  WindowsSize({required this.context});
  double screenWidth(
    double percent,
  ) {
    return MediaQuery.of(context!).size.width * percent;
  }

  double screenHeight({required double percent}) {
    return MediaQuery.of(context!).size.width * percent;
  }
}
