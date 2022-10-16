import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styles/colors.dart';

class LoadingDialogScreen extends StatelessWidget {
  const LoadingDialogScreen({
    Key? key,
    this.color = Colors.black38,
  }) : super(key: key);

  static String id = "loading_dialog_screen";

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const SpinKitDoubleBounce(
        color: primaryColor,
        size: 100.0,
      ),
    );
  }
}
