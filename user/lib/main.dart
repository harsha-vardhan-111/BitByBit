import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/algorithm/algo_results.dart';
import 'screens/algorithm/algo_run.dart';
import 'screens/algorithm/low_battery_demo.dart';
import 'screens/drawer_screens/about_us_screen.dart';
import 'screens/drawer_screens/setting_screen.dart';
import 'screens/home/home_user_data_handler.dart';
import 'screens/login/login.dart';
import 'screens/profile/edit_profile.dart';
import 'screens/registrations/register.dart';
import 'screens/welcome_screen.dart';
import 'styles/colors.dart';
import 'utils/desicion_tree.dart';
import 'widgets/loading_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVon User',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: primaryColor,
              brightness: Brightness.dark,
            ),
      ),
      initialRoute: DesicionTree.id,
      routes: {
        DesicionTree.id: (context) => const DesicionTree(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        EditProfile.id: (context) => const EditProfile(),
        HomeUserDataHandler.id: (context) => const HomeUserDataHandler(),
        LoadingDialogScreen.id: (context) => const LoadingDialogScreen(),
        EditProfile.id: (context) => const EditProfile(),
        SettingScreen.id: (context) => const SettingScreen(),
        AboutUs.id: (context) => const AboutUs(),
        LowBatteryDemo.id: (context) => const LowBatteryDemo(),
        AlgoRun.id: (context) => const AlgoRun(),
        AlgoResults.id: (context) => const AlgoResults(),
      },
    );
  }
}
