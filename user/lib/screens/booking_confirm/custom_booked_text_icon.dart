import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomBookedTextIcon extends StatelessWidget {
  const CustomBookedTextIcon({
    Key? key,
    required this.bgColor,
    required this.icon,
    required this.timer,
  }) : super(key: key);

  final String timer;
  final IconData icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: darkColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            timer,
            style: const TextStyle(
              color: darkColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
