import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_drop_down.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({
    Key? key,
    required this.genderList,
    required this.genderValue,
    required this.onGenderChanged,
    required this.onAddress,
    required this.onDOB,
    required this.onName,
  }) : super(key: key);

  final String genderValue;

  final Function(dynamic) onGenderChanged;

  final List<dynamic> genderList;

  final Function(String?)? onAddress;
  final Function(String?)? onDOB;
  final Function(String?)? onName;

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Please Enter Your Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Personal Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: widget.onName,
          keyboardType: TextInputType.emailAddress,
          cursorColor: primaryColor,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: kFormInputDecoration.copyWith(
            labelText: "Name",
            hintText: "Eg: Dileep",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: widget.onDOB,
          keyboardType: TextInputType.datetime,
          cursorColor: primaryColor,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: kFormInputDecoration.copyWith(
            labelText: "Date of birth",
            hintText: "Eg: 01/01/2001",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your date of birth';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: widget.onAddress,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          style: const TextStyle(
            color: Colors.white,
          ),
          maxLines: 3,
          decoration: kFormInputDecoration.copyWith(
            labelText: "Address",
            hintText: "Eg: Fake Address",
            alignLabelWithHint: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CustomDropDown(
                    lists: widget.genderList,
                    onChanged: widget.onGenderChanged,
                    dropdownValue: widget.genderValue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
