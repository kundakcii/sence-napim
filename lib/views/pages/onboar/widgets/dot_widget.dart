import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';

class Dot extends StatelessWidget {
  const Dot({
    required this.isActive,
    Key? key,
  }) : super(key: key);
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.BERRY_BLUE_GREEN : AppColors.MONTEREY_MIST,
        shape: BoxShape.circle,
      ),
    );
  }
}
