import 'package:evon_user/screens/registrations/register.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../widgets/custom_rounded_button.dart';
import 'login/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static String id = 'new_start';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/backgrounds/background_new_start.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    height: MediaQuery.of(context).size.height / 2.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: darkColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'images/EVon_text_trans.png',
                              width: 120,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "We help you to get the best charging spots for your EV.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomRoundedButton(
                              title: "Get Your Spot",
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.id);
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
