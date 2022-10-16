import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_drop_down.dart';

class VehicalDetails extends StatefulWidget {
  const VehicalDetails({
    Key? key,
    required this.onVehicalRegNo,
    required this.vehicalComp,
    required this.vehicalMod,
    required this.onVehicalCompChange,
    required this.onVehicalModChange,
    required this.modelList,
  }) : super(key: key);

  final String vehicalMod;
  final String vehicalComp;

  final Function(dynamic) onVehicalCompChange;
  final Function(dynamic) onVehicalModChange;

  final List<String> modelList;

  final Function(String?)? onVehicalRegNo;

  @override
  State<VehicalDetails> createState() => _VehicalDetailsState();
}

class _VehicalDetailsState extends State<VehicalDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Vehical Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onSaved: widget.onVehicalRegNo,
          keyboardType: TextInputType.text,
          cursorColor: primaryColor,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: kFormInputDecoration.copyWith(
            labelText: "Vehical Reg.No",
            hintText: "Eg: KA01MM1111",
            alignLabelWithHint: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your vehical reg.no';
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
                      "Vehical Company",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomDropDown(
                      lists: const ['ather', 'ola'],
                      onChanged: widget.onVehicalCompChange,
                      dropdownValue: widget.vehicalComp,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Vehical Model",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomDropDown(
                      lists: widget.modelList,
                      onChanged: widget.onVehicalModChange,
                      dropdownValue: widget.vehicalMod,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
