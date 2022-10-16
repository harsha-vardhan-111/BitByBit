import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evon_user/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page_loading.dart';

class HomeUserDataHandler extends StatefulWidget {
  const HomeUserDataHandler({Key? key}) : super(key: key);

  static String id = "home_page_screen";

  @override
  State<HomeUserDataHandler> createState() => _HomeUserDataHandlerState();
}

class _HomeUserDataHandlerState extends State<HomeUserDataHandler> {
  final String documentId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return HomePageScreen(data: data);
        }

        return const HomePageLoading();
      },
    );
  }
}
