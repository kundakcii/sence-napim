import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sence/constants/app_colors.dart';

class CustomTheme {
  ThemeMode get currentTheme => ThemeMode.light;
  static ThemeData get lightTheme {
    return ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.BERRY_BLUE_GREEN,
          unselectedItemColor: AppColors.BERRY_BLUE_GREEN.withOpacity(0.5),
          selectedLabelStyle: const TextStyle(
            color: AppColors.BERRY_BLUE_GREEN,
            fontSize: 0,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            color: AppColors.BERRY_BLUE_GREEN.withOpacity(0.5),
            fontSize: 0,
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: AppColors.BERRY_BLUE_GREEN,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            shadowColor: AppColors.MONTEREY_MIST));
  }
}
