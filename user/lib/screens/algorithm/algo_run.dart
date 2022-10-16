import 'dart:async';

import 'package:evon_user/screens/algorithm/algo_results.dart';
import 'package:evon_user/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/loading_dialog.dart';

class AlgoRun extends StatefulWidget {
  const AlgoRun({Key? key}) : super(key: key);

  static String id = "algo_run";

  @override
  State<AlgoRun> createState() => _AlgoRunState();
}

class _AlgoRunState extends State<AlgoRun> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  bool isLoading = true;

  Timer? _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: darkColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LoadingDialogScreen(
              color: darkColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Calculating Your Best Route",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      );
    } else {
      return const AlgoResults();
    }
  }
}
