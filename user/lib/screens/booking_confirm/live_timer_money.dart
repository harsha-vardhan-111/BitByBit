import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../styles/colors.dart';
import 'custom_booked_text_icon.dart';

class LiveTimerAmount extends StatelessWidget {
  const LiveTimerAmount({
    Key? key,
    // required this.timer,
    required this.totalAmount,
    required this.charging,
    required this.duration,
  }) : super(key: key);

  // final String timer;
  final String totalAmount;
  final bool charging;

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.black45,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      // CustomBookedTextIcon(
                      //   timer: timer,
                      //   icon: Icons.timer,
                      //   bgColor: Colors.greenAccent,
                      // ),
                      buildTime(),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomBookedTextIcon(
                        timer: totalAmount,
                        icon: FontAwesomeIcons.rupeeSign,
                        bgColor: Colors.yellowAccent,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: charging ? Colors.white10 : primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: charging ? Colors.white : darkColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                charging
                                    ? "Done, Scan again to stop charging"
                                    : "Ready,\nScan to start charging",
                                style: TextStyle(
                                  color: charging ? Colors.white : darkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Lottie.asset(
                      'images/lottie_json/battery.json',
                      animate: charging,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: charging ? Colors.blueAccent : Colors.white24,
                      ),
                      child: const Text(
                        "ATHER",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildTimeCard(time: hours, header: 'HOURS'),
          const Text(
            ":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          buildTimeCard(time: minutes, header: 'MINUTES'),
          const Text(
            ":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          buildTimeCard(time: seconds, header: 'SECONDS'),
        ],
      ),
    );
  }

  Widget buildTimeCard({required String time, required String header}) => Text(
        time,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
        ),
      );
}
