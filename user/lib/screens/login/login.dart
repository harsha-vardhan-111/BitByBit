import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../utils/constants.dart';
import '../../utils/users_auths.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/email_validator.dart';
import '../../widgets/loading_dialog.dart';
import '../home/home_user_data_handler.dart';
import '../registrations/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPassVisible = false;

  bool _isEmailInvalid = false;
  bool _isEmailEmpty = false;
  bool _isPassEmpty = false;

  bool _isLoading = false;

  // ignore: unused_field
  bool _isFireBaseError = false;
  // ignore: unused_field
  String? _firebaseError;

  String? _emailField;
  String? _passField;

  String? _emailError;
  String? _passError;

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
  }

  bool validateErros() {
    if (_isEmailInvalid == false &&
        _isEmailEmpty == false &&
        _isPassEmpty == false) {
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
                                "Welcome Back",
                                style: kHeadline,
                              ),
                              Text(
                                "We missed you",
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
                              "Dont' Have An Account? ",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.id);
                              },
                              child: const Text(
                                "Register",
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
                              _isLoading = true;
                            });
                            if (validateErros()) {
                              _emailField = _emailField!.toLowerCase();
                              Future<String?> regError =
                                  userLoginAuth(_emailField!, _passField!);
                              regError.then((value) {
                                if (value == null) {
                                  _isLoading = false;
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    HomeUserDataHandler.id,
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
                          title: "Login",
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomRoundedButton(
                          onPressed: () {
                            Future<UserCredential> google = signInWithGoogle();
                            google.then(
                              (value) => {
                                Navigator.pop(context),
                                Navigator.pushReplacementNamed(
                                    context, HomeUserDataHandler.id),
                              },
                            );
                          },
                          title: "Login With Google",
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
