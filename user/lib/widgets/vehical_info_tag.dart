import 'package:flutter/material.dart';

class VehicalInfoTag extends StatelessWidget {
  const VehicalInfoTag({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.greenAccent,
          size: 18,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
