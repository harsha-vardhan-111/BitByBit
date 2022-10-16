import 'package:flutter/material.dart';

import '../styles/colors.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    Key? key,
    required this.lists,
    required this.onChanged,
    required this.dropdownValue,
  }) : super(key: key);

  String dropdownValue;

  // ignore: prefer_typing_uninitialized_variables
  final Function(dynamic) onChanged;

  List<dynamic> lists;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButton<dynamic>(
          elevation: 10,
          isExpanded: true,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          iconEnabledColor: primaryColor,
          dropdownColor: darkLight,
          value: widget.dropdownValue,
          underline: Container(),
          style: const TextStyle(
            color: primaryColor,
          ),
          onChanged: widget.onChanged,
          items: widget.lists.map<DropdownMenuItem>(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
