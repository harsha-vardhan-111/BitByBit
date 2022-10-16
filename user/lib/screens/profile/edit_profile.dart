import 'package:evon_user/screens/profile/personal_details.dart';
import 'package:evon_user/screens/profile/vehical_details.dart';
import 'package:evon_user/screens/profile/vehical_specs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../utils/firebase_data_handler.dart';
import '../../utils/getting_data.dart';
import '../home/home_user_data_handler.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static String id = "edit_profile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  String _gender = "male";
  String _vehicalComp = "ather";
  String _vehicalMod = "450X";

  Map<String, List<String>> vehicalModels = {
    'ather': ['450X', '450 Plus'],
    'ola': ['S1 Pro', 'S1']
  };

  Map<String, String>? vehicalSpecs;

  @override
  void initState() {
    super.initState();
    setVehicalSpecs();
  }

  void setVehicalSpecs() {
    vehicalSpecs = vehicalDatas[_vehicalComp]![_vehicalMod];
  }

  String? _name;
  String? _dob;
  String? _address;
  String? _vehicalRegNo;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkColor,
        leading: const Icon(
          Icons.edit,
          color: primaryColor,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          PersonalDetails(
                            onName: (String? value) {
                              _name = value;
                            },
                            onDOB: (String? value) {
                              _dob = value;
                            },
                            onAddress: (String? value) {
                              _address = value;
                            },
                            genderList: const ['male', 'female', 'trans'],
                            onGenderChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                            genderValue: _gender,
                          ),
                          VehicalDetails(
                            onVehicalRegNo: (String? value) {
                              _vehicalRegNo = value;
                            },
                            onVehicalCompChange: (value) {
                              setState(() {
                                _vehicalComp = value;
                                _vehicalMod = vehicalModels[value]![0];
                              });
                              setVehicalSpecs();
                            },
                            onVehicalModChange: (value) {
                              setState(() {
                                _vehicalMod = value;
                              });
                              setVehicalSpecs();
                            },
                            vehicalComp: _vehicalComp,
                            vehicalMod: _vehicalMod,
                            modelList: vehicalModels[_vehicalComp]!,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          VehicalSpecs(
                            vehicalComp: _vehicalComp,
                            vehicalMod: _vehicalMod,
                            vehicalSpecs: vehicalSpecs!,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            Map<String, dynamic> userProfileInfo = {
                              'name': _name,
                              'dob': _dob,
                              'address': _address,
                              'gender': _gender,
                              "vehicalRegNo": _vehicalRegNo,
                              "vehicalComp": _vehicalComp,
                              "vehicalModel": _vehicalMod,
                              "vehicalRange": vehicalSpecs!["range"],
                              "vehicalFastTime":
                                  vehicalSpecs!["fastChargingTime"],
                              "vehicalHomeTime":
                                  vehicalSpecs!["homeChargingTime"],
                            };
                            if (auth.currentUser != null) {
                              setState(() {
                                isLoading = true;
                              });
                              Future<bool> user = addUser(
                                  auth.currentUser!.uid, userProfileInfo);
                              user.then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    HomeUserDataHandler.id,
                                  );
                                } else {
                                  const snackbar = SnackBar(
                                    content: Text("Error Updating Data"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              });
                            } else {
                              const snackbar = SnackBar(
                                content: Text("User Not Found"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: darkColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
