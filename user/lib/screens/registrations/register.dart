import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../utils/constants.dart';
import '../../utils/users_auths.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/email_validator.dart';
import '../../widgets/loading_dialog.dart';
import '../login/login.dart';
import '../profile/edit_profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static String id = "enter_name_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  bool _isPassVisible = false;
  bool _isRePassVisible = false;

  bool _isEmailInvalid = false;
  bool _isEmailEmpty = false;
  bool _isPassEmpty = false;
  bool _isRePassEmpty = false;
  bool _isPassMatch = true;

  bool _isFireBaseError = false;
  String? _firebaseError;

  String? _emailField;
  String? _passField;
  String? _rePassField;

  String? _emailError;
  String? _passError;
  String? _rePassError;

  String? _passMatchError;
  final String _validateEmailError = "Please enter a valid email";

  void validateEmail() {
    _isEmailInvalid = !emailValidator(_emailField!);
  }

  void checkEmptyFields() {
    if (_emailField == "" || _emailField == null) {
      _isEmailEmpty = true;
      _emailError = "Please enter en email";
    } else {
      _isEmailEmpty = false;
      validateEmail();
    }
    if (_passField == "" || _passField == null) {
      _isPassEmpty = true;
      _passError = "Please enter a password";
    } else {
      _isPassEmpty = false;
    }
    if (_rePassField == "" || _rePassField == null) {
      _isRePassEmpty = true;
      _rePassError = "Please enter your password again";
    } else {
      _isRePassEmpty = false;
    }
  }

  void checkPassMatch() {
    if (_passField != _rePassField) {
      _isPassMatch = false;
      _passMatchError = "Passwords are not matching";
    } else {
      _isPassMatch = true;
    }
  }

  bool validateErros() {
    if (_isEmailInvalid == false &&
        _isEmailEmpty == false &&
        _isPassEmpty == false &&
        _isRePassEmpty == false &&
        _isPassMatch == true) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "images/icons/custom_back_icon.png",
            width: 24,
          ),
        ),
      ),
      backgroundColor: darkColor,
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Register",
                                style: kHeadline,
                              ),
                              Text(
                                "Create a new account to get started",
                                style: kBodyText2,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _emailField = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: primaryColor,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: kInputDecoration.copyWith(
                                  labelText: "Email",
                                  prefixIcon: const Icon(
                                    Icons.email,
                                  ),
                                  errorText: _isEmailEmpty
                                      ? _emailError
                                      : _isEmailInvalid
                                          ? _validateEmailError
                                          : null,
                                  errorStyle: kErrorStyle,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _passField = value;
                                },
                                obscureText: _isPassVisible ? false : true,
                                keyboardType: TextInputType.text,
                                cursorColor: primaryColor,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: kInputDecoration.copyWith(
                                  labelText: "Password",
                                  prefixIcon: const Icon(
                                    Icons.password_rounded,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPassVisible = !_isPassVisible;
                                      });
                                    },
                                    icon: _isPassVisible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  errorText: _isPassEmpty ? _passError : null,
                                  errorStyle: kErrorStyle,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _rePassField = value;
                                },
                                obscureText: _isRePassVisible ? false : true,
                                keyboardType: TextInputType.text,
                                cursorColor: primaryColor,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: kInputDecoration.copyWith(
                                  labelText: "Re-Password",
                                  prefixIcon: const Icon(
                                    Icons.password_rounded,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isRePassVisible = !_isRePassVisible;
                                      });
                                    },
                                    icon: _isRePassVisible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  errorText: _isRePassEmpty
                                      ? _rePassError
                                      : _isPassMatch
                                          ? null
                                          : _passMatchError,
                                  errorStyle: kErrorStyle,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              _isFireBaseError
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                      child: Text(
                                        _firebaseError!,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already Have An Account? ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  LoginScreen.id,
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomRoundedButton(
                          onPressed: () {
                            setState(() {
                              checkEmptyFields();
                              checkPassMatch();
                              _isLoading = true;
                            });
                            if (validateErros()) {
                              _emailField = _emailField!.toLowerCase();
                              Future<String?> regError =
                                  userRegisterAuth(_emailField!, _rePassField!);
                              regError.then((value) {
                                if (value == null) {
                                  _isLoading = false;
                                  Navigator.pop(context);
                                  Navigator.popAndPushNamed(
                                    context,
                                    EditProfile.id,
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                    _isFireBaseError = true;
                                    _firebaseError = value;
                                  });
                                }
                              });
                            } else {
                              _isLoading = false;
                            }
                          },
                          title: "Register",
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomRoundedButton(
                          onPressed: () {
                            // Future<UserCredential> google = signInWithGoogle();
                            // google.then(
                            //   (value) => {
                            //     Navigator.pop(context),
                            //     Navigator.pushReplacementNamed(
                            //       context,
                            //       EditProfile.id,
                            //     ),
                            //   },
                            // );
                          },
                          title: "Register With Google",
                          backgroundColor: Colors.white,
                          isIcon: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading ? const LoadingDialogScreen() : Container()
        ],
      ),
    );
  }
}
