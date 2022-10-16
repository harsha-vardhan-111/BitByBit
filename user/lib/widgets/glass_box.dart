import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  const GlassBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(
          20,
        ),
        topLeft: Radius.circular(
          20,
        ),
      ),
      child: SizedBox(
        child: Stack(
          children: [
            // blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                    0.5,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
