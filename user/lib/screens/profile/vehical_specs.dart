import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_text.dart';

class VehicalSpecs extends StatelessWidget {
  const VehicalSpecs(
      {Key? key,
      required this.vehicalComp,
      required this.vehicalMod,
      required this.vehicalSpecs})
      : super(key: key);

  final String vehicalComp;
  final String vehicalMod;
  final Map<String, String> vehicalSpecs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                vehicalComp.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                vehicalMod,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          IconText(
            title: vehicalSpecs['range']!,
            icon: FontAwesomeIcons.road,
          ),
          const SizedBox(
            height: 15,
          ),
          IconText(
            title: vehicalSpecs['fastChargingTime']!,
            icon: FontAwesomeIcons.chargingStation,
          ),
          const SizedBox(
            height: 15,
          ),
          IconText(
            title: vehicalSpecs['homeChargingTime']!,
            icon: FontAwesomeIcons.batteryFull,
          ),
        ],
      ),
    );
  }
}
