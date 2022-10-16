import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static String id = "setting_screen";

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            "images/icons/custom_back_icon.png",
            width: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SettingLists(
                  title: "Edit Vehicals",
                  icon: Icons.edit,
                ),
                SettingLists(title: "Edit Location", icon: Icons.edit_location),
                SettingLists(title: "Change Password", icon: Icons.password),
                SettingLists(
                    title: "Find My Vehical", icon: Icons.location_city),
                SettingLists(title: "Delete Account", icon: Icons.delete),
              ],
            ),
            Column(
              children: const [
                Text(
                  "EVon",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Build - HE18AHOI00Q1889",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingLists extends StatelessWidget {
  const SettingLists({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
