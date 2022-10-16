import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVon Merchant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: DesicionTree.id,
      routes: {
        DesicionTree.id: (context) => const DesicionTree(),
        BottomNavBar.id: (context) => const BottomNavBar(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        AddProfile.id: (context) => const AddProfile(),
        BookChargerScreen.id: (context) => const BookChargerScreen(),
      },
    );
  }
}
