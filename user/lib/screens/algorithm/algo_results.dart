import 'package:evon_user/screens/home/home_user_data_handler.dart';
import 'package:evon_user/styles/colors.dart';
import 'package:flutter/material.dart';

import '../search_results/map.dart';
import 'package:share_plus/share_plus.dart';

class AlgoResults extends StatefulWidget {
  const AlgoResults({Key? key}) : super(key: key);

  static String id = "algo_results";

  @override
  State<AlgoResults> createState() => _AlgoResultsState();
}

class _AlgoResultsState extends State<AlgoResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          title: const Text(
            "Best Route - EVon Algo",
          ),
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Expected Reach Time"),
                            Text(
                              "11:55 AM",
                              style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Nearest Charging Station",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "REVA Univesity",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text("Srinivasa Nagar"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star,
                                  color: i < 4 ? primaryColor : Colors.white,
                                  size: 20,
                                ),
                              ).toList(),
                            ),
                            const Text(
                              "50 m",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const MapDirection(
                                  lat: 12.8732,
                                  lon: 77.5761,
                                );
                              },
                            );
                          },
                          child: Image.asset(
                            "images/icons/google_map_icon.png",
                            scale: 8,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                                'https://www.google.com/maps/search/?api=1&query=12.8732,77.5761');
                          },
                          child: const Icon(
                            Icons.share,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, HomeUserDataHandler.id);
                          },
                          child: const Text(
                            "Book The Charger",
                            style: TextStyle(
                              color: darkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ---------------------------------------------------------- //
                  const SizedBox(
                    height: 80,
                  ),
                  // ---------------------------------------------------------- //
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Recommended Battery Percentage",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            "images/icons/low_battery.png",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Charge"),
                              Text(
                                "30%",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Text("To reach your destination"),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text("Total Time"),
                                Text(
                                  "10 min",
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ---------------------------------------------------------- //
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Image.asset(
                      "images/icons/line.png",
                      scale: 10,
                    ),
                  ),
                  // ---------------------------------------------------------- //
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Destination",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text("M S Palya"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text("Ride Mode"),
                            Text(
                              "Eco",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const MapDirection(
                                  lat: 13.0813,
                                  lon: 77.5483,
                                );
                              },
                            );
                          },
                          child: Image.asset(
                            "images/icons/google_map_icon.png",
                            scale: 8,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                                'https://www.google.com/maps/search/?api=1&query=13.0813,77.5483');
                          },
                          child: const Icon(
                            Icons.share,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
