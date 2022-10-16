import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evon_user/screens/booking_confirm/timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../styles/colors.dart';
import '../../utils/firebase_data_handler.dart';

class BookingSuccess extends StatefulWidget {
  const BookingSuccess({
    Key? key,
    required this.stationId,
  }) : super(key: key);

  static String id = "booking_success";
  final String stationId;

  @override
  State<BookingSuccess> createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {
  Stream<DocumentSnapshot>? documentStream;
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    documentStream = FirebaseFirestore.instance
        .collection('ChargingStations')
        .doc(widget.stationId)
        .collection("chargers")
        .doc("charger 0")
        .snapshots();

    streamSubscription = documentStream!.listen((event) {
      if (event.get('charging')) {
        startTimer();
      } else {
        if (timer != null) {
          stopTimer();
        }
      }
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  Future<void> deleteChargerRequests() async {
    return await FirebaseFirestore.instance
        .collection('ChargingRequest')
        .doc(widget.stationId)
        .collection('RequestedUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
  }

  Future<void> changeFinished() async {
    FirebaseFirestore.instance
        .collection('ChargingStations')
        .doc(widget.stationId)
        .collection('chargers')
        .doc('charger 0')
        .update({
      'isFinished': false,
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    changeFinished().then((value) {
      updateChargerInfo(widget.stationId, finalAmount.toStringAsFixed(2))
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        deleteChargerRequests();
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  // payment options
  double finalAmount = 00.00;
  double totalAmount = 0;
  final _razorpay = Razorpay();

  // All timer codes
  // ------------------------ TIMER ------------------------------- //

  static const countdownDuration = Duration(minutes: 45);
  Duration duration = const Duration();
  Timer? timer;

  bool countDown = true;

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    reset();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer!.cancel();
      } else {
        duration = Duration(seconds: seconds);
        setState(() {
          finalAmount += 0.5;
        });
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer!.cancel();
      totalAmount =
          double.parse((finalAmount + (finalAmount * 0.18)).toStringAsFixed(2));
    });
  }

  // ------------------------ TIMER ------------------------------- //

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Are you sure want to leave?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  engageCharger();
                  willLeave = true;
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              )
            ],
          ),
        );
        return willLeave;
      },
      child: Scaffold(
        backgroundColor: darkColor,
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
              stream: documentStream,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: darkColor,
                  );
                }

                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TimerScreen(
                              isCharging: snapshot.data!.get('charging'),
                              duration: duration,
                              amount: finalAmount,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryColor,
                                width: 5,
                              ),
                            ),
                            child: QrImage(
                              data: widget.stationId,
                              foregroundColor: primaryColor,
                              size: 200,
                            ),
                          ),
                        ),
                      ],
                    ),
                    snapshot.data!.get('isFinished')
                        ? Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              title: const Text("Your Billing"),
                              backgroundColor: primaryColor,
                              centerTitle: true,
                              elevation: 0,
                            ),
                            body: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: darkColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Charging amount: ",
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "Rs. ${finalAmount.toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                color: primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "GST: ",
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "Rs. ${(finalAmount * 0.18).toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                color: primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          color: primaryColor,
                                          thickness: 2,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Amount: ",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "Rs. $totalAmount",
                                              style: const TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21.5,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        var options = {
                                          'key': 'rzp_test_LfHajwAPlYYwHO',
                                          'amount': finalAmount *
                                              100, //in the smallest currency sub-unit.
                                          'name': 'Charger',
                                          'description': 'Demo',
                                          'timeout': 300, // in seconds
                                          'prefill': {
                                            'contact': '+918217743991',
                                            'email': 'dileep@gmail.com'
                                          }
                                        };
                                        _razorpay.open(options);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.money,
                                            color: darkColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "PAY",
                                            style: TextStyle(
                                              color: darkColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              }),
        ),
      ),
    );
  }
}
