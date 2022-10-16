import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> addUser(String uid, Map<String, dynamic> userProfileInfo) {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  return users.doc(uid).set(
    {
      'name': userProfileInfo['name'],
      'dob': userProfileInfo['dob'],
      'address': userProfileInfo['address'],
      'gender': userProfileInfo['gender'],
      "vehicalRegNo": userProfileInfo['vehicalRegNo'],
      "vehicalComp": userProfileInfo['vehicalComp'],
      "vehicalModel": userProfileInfo['vehicalModel'],
      "vehicalRange": userProfileInfo['vehicalRange'],
      "vehicalFastTime": userProfileInfo['vehicalFastTime'],
      "vehicalHomeTime": userProfileInfo['vehicalHomeTime'],
    },
  ).then((value) {
    return true;
  }).catchError((error) {
    return false;
  });
}

Future<DocumentSnapshot?> getUserData(String uid) async {
  return FirebaseFirestore.instance.collection('Users').doc(uid).get().then(
    (DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        return null;
      }
    },
  ).catchError((error) {
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
}

Future<bool> requestBooking(
    String uid, String stationId, String estTime, DocumentSnapshot userData) {
  CollectionReference chargingRequest =
      FirebaseFirestore.instance.collection('ChargingRequest');

  return chargingRequest
      .doc(stationId)
      .collection("RequestedUser")
      .doc(uid)
      .set(
    {
      "accepted": false,
      "declined": false,
      "estTime": estTime,
      'startTime': false,
      "username": userData.get("name"),
      "vehicalComp": userData.get("vehicalComp"),
      "vehicalModel": userData.get("vehicalModel"),
      "vehicalRegNo": userData.get("vehicalRegNo"),
    },
  ).then((value) {
    return true;
  }).catchError((error) {
    Fluttertoast.showToast(
      msg: error.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return false;
  });
}

Future<bool> engageCharger() async {
  CollectionReference chargingStations =
      FirebaseFirestore.instance.collection('ChargingStations');
  chargingStations
      .doc("QrfuooxdaEVjPNU2iNCB2PqKctG2")
      .collection('chargers')
      .doc('charger 0')
      .update({'isEngaged': false}).then((value) {
    return true;
  });
  return false;
}

Future<bool> updateChargerInfo(String stationId, String amount) async {
  CollectionReference chargingStations =
      FirebaseFirestore.instance.collection('ChargingStations');
  chargingStations
      .doc(stationId)
      .collection('chargers')
      .doc('charger 0')
      .update({
    'totalEarnings': amount,
    'showPayment': true,
    'receivePayment': amount,
  }).then((value) {
    return true;
  });
  return false;
}
