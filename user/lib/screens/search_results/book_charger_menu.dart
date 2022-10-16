import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/glass_box.dart';

class BookChargerMenu extends StatefulWidget {
  const BookChargerMenu({
    required this.onValueChanged,
    required this.isHomeSelected,
    required this.isFastSelected,
    required this.snapshot,
    required this.dropdownValue,
    Key? key,
  }) : super(key: key);

  final Function(dynamic) onValueChanged;
  final String dropdownValue;

  final bool isHomeSelected;
  final bool isFastSelected;
  final DocumentSnapshot snapshot;

  @override
  State<BookChargerMenu> createState() => _BookChargerMenuState();
}

class _BookChargerMenuState extends State<BookChargerMenu> {
  bool isHome = true;

  DocumentSnapshot? snapshot;

  @override
  void initState() {
    super.initState();
    isHome = widget.isHomeSelected;
    snapshot = widget.snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          const GlassBox(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot!.get('name'),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: i < snapshot!.get('stars')
                                ? primaryColor
                                : Colors.white,
                            size: 20,
                          ),
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Book a ${isHome ? "Home" : "Fast"} charger @${snapshot!.get('name')} for an about...",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomDropDown(
                    dropdownValue: widget.dropdownValue,
                    onChanged: widget.onValueChanged,
                    lists: const <String>[
                      '60 min',
                      '45 min',
                      '30 min',
                      '15 min',
                      '10 min'
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
