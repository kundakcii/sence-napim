import 'package:flutter/material.dart';

class CustomDvider extends StatelessWidget {
  const CustomDvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
    );
  }
}
