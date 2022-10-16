import 'package:evon_user/screens/algorithm/algo_run.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/colors.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/vehical_info_tag.dart';

class LowBatteryDemo extends StatefulWidget {
  const LowBatteryDemo({Key? key}) : super(key: key);

  static String id = "low_battery_demo";

  @override
  State<LowBatteryDemo> createState() => _LowBatteryDemoState();
}

class _LowBatteryDemoState extends State<LowBatteryDemo> {
  bool isHomeSelected = false;
  bool isFastSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const HomeDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Hey, Dileep Kumar Sharma",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 30,
            left: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade100.withAlpha(80),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                "images/icons/low_battery.png",
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Low Battery!!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text("Maximum Range: 3 Km"),
                                  const Text("Battery Percentage: 7%"),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, AlgoRun.id);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    child: const Text(
                                      "Calculate Best Route",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "ATHER",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "450 PLUS",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "images/avatar/ele_scooter_avatar.png",
                        scale: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 20.0,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Flexible(
                                  flex: 1,
                                  child: VehicalInfoTag(
                                    title: "1.5km/min",
                                    icon: FontAwesomeIcons.chargingStation,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: VehicalInfoTag(
                                    title: "KA 01 MK 1234",
                                    icon: FontAwesomeIcons.clipboard,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Flexible(
                                  flex: 1,
                                  child: VehicalInfoTag(
                                    title: "3.35 Hours",
                                    icon: FontAwesomeIcons.batteryFull,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: VehicalInfoTag(
                                    title: "100 KM",
                                    icon: FontAwesomeIcons.road,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isHomeSelected = true;
                          isFastSelected = false;
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.home,
                        size: 20,
                        color: isHomeSelected && !isFastSelected
                            ? darkColor
                            : primaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: isHomeSelected && !isFastSelected
                            ? Colors.blueAccent
                            : Colors.transparent,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isHomeSelected = false;
                          isFastSelected = true;
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.bolt,
                        size: 20,
                        color: isFastSelected && !isHomeSelected
                            ? darkColor
                            : primaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: isFastSelected && !isHomeSelected
                            ? Colors.yellowAccent.shade700
                            : Colors.transparent,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(15),
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
                  if (isHomeSelected != false || isFastSelected != false) {
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please select atleast one charging type",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                title: "Search",
                backgroundColor: primaryColor,
                textColor: darkColor,
                elevation: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
