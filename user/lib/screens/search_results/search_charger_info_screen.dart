// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evon_user/screens/search_results/search_result_scroll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../styles/colors.dart';
import '../../utils/firebase_data_handler.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/loading_dialog.dart';
import '../booking_confirm/booking_confirmation.dart';
import 'book_charger_menu.dart';
import 'map.dart';

class SearchChargerInfoScreen extends StatefulWidget {
  const SearchChargerInfoScreen({
    Key? key,
    required this.id,
    required this.isHome,
    required this.isFast,
  }) : super(key: key);

  final String id;
  final bool isHome;
  final bool isFast;

  @override
  State<SearchChargerInfoScreen> createState() =>
      _SearchChargerInfoScreenState();
}

class _SearchChargerInfoScreenState extends State<SearchChargerInfoScreen>
    with TickerProviderStateMixin<SearchChargerInfoScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? result;

  AnimationController? animationController;

  bool isHome = false;
  bool isFast = false;

  bool isBook = false;

  String estTime = "30 min";

  double yPos = 4;

  DocumentSnapshot? snapshot;

  bool isLoading = true;
  bool isBooking = false;

  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    isHome = widget.isHome;
    isFast = widget.isFast;

    FirebaseFirestore.instance
        .collection('ChargingStations')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        snapshot = documentSnapshot;
        setState(() {
          isLoading = false;
          latitude = snapshot!.get("latlon")[0];
          longitude = snapshot!.get("latlon")[1];
        });
      } else {
        // ignore: avoid_print
        print('Document does not exist on the database');
      }
    });
  }

  void showMenu() {
    setState(() {
      yPos = 1;
    });
  }

  void hideMenu() {
    setState(() {
      yPos = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          )),
      backgroundColor: darkColor,
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 7,
                child: Stack(
                  children: [
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SearchResultScroll(
                            snapshot: snapshot!,
                          ),
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      alignment: Alignment(0, yPos),
                      curve: Curves.linear,
                      child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isBook = false;
                                });
                                hideMenu();
                              },
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : BookChargerMenu(
                                    snapshot: snapshot!,
                                    isFastSelected: isFast,
                                    isHomeSelected: isHome,
                                    dropdownValue: estTime,
                                    onValueChanged: (dynamic estTime) {
                                      setState(() {
                                        this.estTime = estTime;
                                      });
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: darkColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MapDirection(
                                lat: latitude,
                                lon: longitude,
                              );
                            },
                          );
                        },
                        icon: Image.asset(
                          "images/icons/google_map_icon.png",
                        ),
                      ),
                      Expanded(
                        child: isBook
                            ? CustomRoundedButton(
                                onPressed: () {
                                  setState(() {
                                    isBooking = true;
                                  });
                                  bookCharger();
                                },
                                title: "Confirm",
                                backgroundColor: Colors.greenAccent,
                                isIcon: true,
                                imagePath: "images/icons/book.png",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : CustomRoundedButton(
                                onPressed: () {
                                  setState(() {
                                    isBook = true;
                                  });
                                  showMenu();
                                },
                                title: "Book Charger",
                                backgroundColor: primaryColor,
                                isIcon: true,
                                imagePath: "images/icons/book.png",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          isBooking ? const LoadingDialogScreen() : Container()
        ],
      ),
    );
  }

  void bookCharger() {
    Future<DocumentSnapshot?> getUser = getUserData(auth.currentUser!.uid);

    getUser.then((value) {
      if (value != null) {
        Future<bool> requestedBook =
            requestBooking(auth.currentUser!.uid, widget.id, estTime, value);
        requestedBook.then((value) {
          if (value) {
            setState(() {
              isBooking = false;
            });
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmation(
                  estTime: estTime,
                  stationId: widget.id,
                ),
              ),
            );
          } else {
            setState(() {
              isBooking = false;
            });
            Fluttertoast.showToast(
              msg: "Not able to book, check your internet connection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        });
      } else {
        setState(() {
          isBooking = false;
        });
        Fluttertoast.showToast(
          msg: "Not able to get user data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }
}
