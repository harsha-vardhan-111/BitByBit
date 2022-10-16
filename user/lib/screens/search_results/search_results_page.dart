import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../widgets/search_result_card.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({
    Key? key,
    this.isFastSelected = false,
    this.isHomeSelected = false,
  }) : super(key: key);

  static String id = "search_results_screen";

  final bool isHomeSelected;
  final bool isFastSelected;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  bool? isFastSelected;
  bool? isHomeSelected;

  @override
  void initState() {
    super.initState();
    isFastSelected = widget.isFastSelected;
    isHomeSelected = widget.isHomeSelected;
  }

  Stream<QuerySnapshot>? chargerData(bool isFastSelected, bool isHomeSelected) {
    return FirebaseFirestore.instance
        .collection('ChargingStations')
        .where('isActive', isEqualTo: true)
        .where('isFastCharger', isEqualTo: isFastSelected)
        .where('isHomeCharger', isEqualTo: isHomeSelected)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        title: Image.asset(
          "images/EVon_text_trans.png",
          width: 70,
        ),
        backgroundColor: darkColor,
        elevation: 0,
        actions: <Widget>[
          widget.isHomeSelected
              ? const Icon(
                  Icons.home,
                  color: Colors.blueAccent,
                )
              : Container(),
          const SizedBox(
            width: 10,
          ),
          widget.isFastSelected
              ? Icon(
                  Icons.bolt,
                  color: Colors.yellowAccent.shade700,
                )
              : Container(),
          const SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "images/icons/custom_back_icon.png",
            width: 24,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            bottom: 30.0,
            right: 20.0,
            left: 20.0,
            top: 20.0,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: chargerData(isFastSelected!, isHomeSelected!),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Opps, Can't find any charging stations",
                      style: TextStyle(
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  log(document.reference.id);
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return SearchResultCard(
                    id: document.reference.id,
                    stars: data['stars'],
                    avail: data['avail'],
                    title: data['name'],
                    loc: data['loc'],
                    index: data['index'],
                    isHome: data['isHomeCharger'],
                    isFast: data['isFastCharger'],
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
