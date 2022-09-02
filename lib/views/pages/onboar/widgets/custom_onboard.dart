import 'package:flutter/material.dart';

class CustomOnboard extends StatelessWidget {
  const CustomOnboard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image, title;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: height / 10 * 8,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
