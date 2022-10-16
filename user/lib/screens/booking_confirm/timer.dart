import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'live_timer_money.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({
    Key? key,
    required this.isCharging,
    required this.duration,
    required this.amount,
  }) : super(key: key);

  final bool isCharging;
  final Duration duration;
  final double amount;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  "Your Charger Is Booked And Ready To Serve You",
                  style: TextStyle(
                    fontSize: 14,
                    color: darkColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            LiveTimerAmount(
              totalAmount:
                  double.parse((widget.amount).toStringAsFixed(2)).toString(),
              charging: widget.isCharging,
              duration: widget.duration,
            )
          ],
        ),
      ],
    );
  }
}
