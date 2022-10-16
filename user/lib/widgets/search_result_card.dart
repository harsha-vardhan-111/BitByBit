import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/search_results/search_charger_info_screen.dart';
import '../styles/colors.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    Key? key,
    this.stars = 2,
    this.distance = 50,
    this.title = "Title",
    this.loc = "Descriptions",
    this.avail = 0,
    required this.id,
    required this.isHome,
    required this.isFast,
    required this.index,
  }) : super(key: key);

  final String id;
  final int stars;
  final int distance;

  final String title;
  final String loc;

  final int avail;
  final int index;

  final bool isHome;
  final bool isFast;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: darkLight,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchChargerInfoScreen(
                id: id,
                isHome: isHome,
                isFast: isFast,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 2,
                child: Image.asset(
                  "images/icons/elec_charger_icon.png",
                  height: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  color: Colors.white30,
                  width: 1,
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          loc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: i < stars ? primaryColor : Colors.white,
                            size: 20,
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          FontAwesomeIcons.plug,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          avail.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: avail > 2
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    Text("${distance.toString()} m"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isHome
                            ? const Icon(
                                Icons.home,
                                size: 15,
                                color: Colors.blueAccent,
                              )
                            : Container(),
                        isFast
                            ? Icon(
                                Icons.bolt,
                                size: 15,
                                color: Colors.yellowAccent.shade700,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
