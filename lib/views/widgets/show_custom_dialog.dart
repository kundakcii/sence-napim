import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/windows_size.dart';
import 'package:sence/views/pages/auth/widgets/logo_image.dart';

class ShowCustomDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset("assets/images/question_mark.png"),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: WindowsSize(context: context).screenHeight(percent: 0.4),
            child: const LogoImage(),
          ),
          const Center(
            child: CircularProgressIndicator(
                color: AppColors.MONTEREY_MIST,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.BERRY_BLUE_GREEN),
                backgroundColor: AppColors.MONTEREY_MIST),
          ),
        ],
      ),
    );
  }

  static void showAlert({
    required BuildContext context,
    required String content,
    required String title,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
