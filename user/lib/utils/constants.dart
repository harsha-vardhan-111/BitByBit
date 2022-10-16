import 'package:flutter/material.dart';

import '../styles/colors.dart';

double kInputFormBR = 15;

var kInputDecoration = const InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
    borderSide: BorderSide(
      color: textGrey,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        20,
      ),
    ),
    borderSide: BorderSide(
      color: primaryColor,
    ),
  ),
  focusColor: primaryColor,
  labelText: 'Enter a Value',
  labelStyle: TextStyle(
    color: textGrey,
  ),
  floatingLabelStyle: TextStyle(
    color: primaryColor,
  ),
);

var kFormInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(
    vertical: 20.0,
    horizontal: 10,
  ),
  border: OutlineInputBorder(
    gapPadding: 8,
    borderRadius: BorderRadius.all(
      Radius.circular(kInputFormBR),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        kInputFormBR,
      ),
    ),
    borderSide: const BorderSide(
      color: textGrey,
    ),
  ),
  focusColor: primaryColor,
  labelText: 'Enter a Value',
  hintText: "Dileep Kumar Sharma",
  labelStyle: const TextStyle(
    color: textGrey,
  ),
  floatingLabelStyle: const TextStyle(
    color: primaryColor,
  ),
);

double kTextFieldHeight = 60;

var kHeadline = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

var kBodyText2 = const TextStyle(
  fontSize: 25,
);

var kErrorStyle = const TextStyle(
  color: Colors.redAccent,
  fontWeight: FontWeight.bold,
);
