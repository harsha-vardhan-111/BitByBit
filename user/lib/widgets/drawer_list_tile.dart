import 'package:flutter/material.dart';

import '../styles/colors.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    required this.onTap,
    required this.title,
    this.leading,
    Key? key,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          color: primaryColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
