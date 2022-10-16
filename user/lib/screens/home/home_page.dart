import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/colors.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/home_drawer.dart';
import '../../widgets/vehical_info_tag.dart';
import '../search_results/search_results_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String dropdownValue = 'OLA';

  bool isHomeSelected = false;
  bool isFastSelected = false;

  // List<Map<String, String>>? vehical;

  @override
  void initState() {
    super.initState();
    // changeVehical(dropdownValue);
  }

  // void changeVehical(value) {
  //   vehical = vehicals[value]!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Hey, ${widget.data['name']}",
          style: const TextStyle(
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
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.data['vehicalComp'].toString().toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.data['vehicalModel'].toString().toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child:
                          Image.asset("images/avatar/ele_scooter_avatar.png"),
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
                            children: [
                              Flexible(
                                flex: 1,
                                child: VehicalInfoTag(
                                  title:
                                      widget.data['vehicalFastTime'].toString(),
                                  icon: FontAwesomeIcons.chargingStation,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: VehicalInfoTag(
                                  title: widget.data['vehicalRegNo'].toString(),
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
                            children: [
                              Flexible(
                                flex: 1,
                                child: VehicalInfoTag(
                                  title:
                                      widget.data['vehicalHomeTime'].toString(),
                                  icon: FontAwesomeIcons.batteryFull,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: VehicalInfoTag(
                                  title: widget.data['vehicalRange'].toString(),
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
              const SizedBox(
                height: 50,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResults(
                            isFastSelected: isFastSelected,
                            isHomeSelected: isHomeSelected,
                          ),
                        ));
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
