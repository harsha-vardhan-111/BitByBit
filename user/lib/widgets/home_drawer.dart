import 'package:evon_user/screens/algorithm/low_battery_demo.dart';
import 'package:evon_user/widgets/drawer_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/drawer_screens/about_us_screen.dart';
import '../screens/drawer_screens/setting_screen.dart';
import '../styles/colors.dart';
import '../utils/desicion_tree.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: darkColor,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "images/EVon_trans.png",
              ),
            ),
          ),
          DrawerListTile(
            leading: const Icon(
              FontAwesomeIcons.idCard,
              color: primaryColor,
              size: 20,
            ),
            onTap: () {},
            title: "Profile",
          ),
          DrawerListTile(
            leading: const Icon(
              Icons.contact_page,
              color: primaryColor,
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                AboutUs.id,
              );
            },
            title: "About Us",
          ),
          DrawerListTile(
            leading: const Icon(
              Icons.phone,
              color: primaryColor,
            ),
            onTap: () {},
            title: "Contact Us",
          ),
          DrawerListTile(
            leading: const Icon(
              Icons.settings,
              color: primaryColor,
            ),
            onTap: () {
              Navigator.pushNamed(context, SettingScreen.id);
            },
            title: "Settings",
          ),
          DrawerListTile(
            leading: const Icon(
              Icons.developer_mode,
              color: primaryColor,
            ),
            onTap: () {
              Navigator.pushNamed(context, LowBatteryDemo.id);
            },
            title: "Algo Demo",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DrawerListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: primaryColor,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, DesicionTree.id);
                  },
                  title: "Logout",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
