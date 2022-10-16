import 'package:flutter/material.dart';

class StartEndTimer extends StatelessWidget {
  const StartEndTimer({
    Key? key,
    required this.time,
    required this.timeTitle,
  }) : super(key: key);

  final String timeTitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeTitle,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }
}
