import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../styles/colors.dart';
import 'booking_success.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation(
      {Key? key, required this.estTime, required this.stationId})
      : super(key: key);

  final String estTime;
  final String stationId;

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  Stream<DocumentSnapshot>? documentStream;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    documentStream = FirebaseFirestore.instance
        .collection('ChargingRequest')
        .doc(widget.stationId)
        .collection("RequestedUser")
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<DocumentSnapshot>(
            stream: documentStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return snapshot.data!.get("accepted")
                  ? BookingSuccess(
                      stationId: widget.stationId,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SpinKitDoubleBounce(
                          color: primaryColor,
                          size: 200.0,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Waiting For The Merch To Accept\nYour Booking",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
