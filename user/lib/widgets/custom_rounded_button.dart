import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    required this.onPressed,
    required this.title,
    this.isIcon = false,
    this.textColor = darkColor,
    this.backgroundColor = primaryColor,
    this.elevation = 3,
    this.imagePath = "images/icons/google_icon.png",
    this.style,
    Key? key,
  }) : super(key: key);

  final Color textColor;
  final Color backgroundColor;
  final String title;
  final bool isIcon;
  final double elevation;
  final String imagePath;

  final TextStyle? style;

  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(15),
        primary: textColor,
        backgroundColor: backgroundColor,
        shape: const StadiumBorder(),
        elevation: elevation,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIcon
              ? Image.asset(
                  imagePath,
                  width: 18,
                )
              : Container(),
          isIcon
              ? const SizedBox(
                  width: 8,
                )
              : Container(),
          Text(
            title,
            style: style,
          ),
        ],
      ),
    );
  }
}
