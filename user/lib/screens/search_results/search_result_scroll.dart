import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/colors.dart';
import '../../utils/getting_data.dart';

class SearchResultScroll extends StatefulWidget {
  const SearchResultScroll({Key? key, required this.snapshot})
      : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  State<SearchResultScroll> createState() => _SearchResultScrollState();
}

class _SearchResultScrollState extends State<SearchResultScroll> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  DocumentSnapshot? snapshot;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    snapshot = widget.snapshot;
  }

  final List<String> imgList = [
    "images/display/image2.png",
    "images/display/image3.png",
    "images/display/image4.png",
    "images/display/image5.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot!.get('name'),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    FontAwesomeIcons.map,
                    size: 20,
                  ),
                  title: Text(
                    snapshot!.get('address'),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.plug,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot!.get('avail').toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: snapshot!.get('avail') > 2
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "50 m",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        snapshot!.get('isHomeCharger')
                            ? const Icon(
                                Icons.home,
                                size: 25,
                                color: Colors.blueAccent,
                              )
                            : Container(),
                        snapshot!.get('isFastCharger')
                            ? Icon(
                                Icons.bolt,
                                size: 25,
                                color: Colors.yellowAccent.shade700,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              CarouselSlider(
                items: [2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/display/image$i.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                          _current == entry.key ? 0.9 : 0.4,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Prices",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                snapshot!.get('isHomeCharger')
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.home,
                            size: 25,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            "Rs.14 - 30 min",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                snapshot!.get('isFastCharger')
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 25,
                            color: Colors.yellowAccent.shade700,
                          ),
                          const Text(
                            "Rs.29 - 30 min",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "User Reviews",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: List.generate(
              userReview.length,
              (index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        FontAwesomeIcons.userCircle,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userReview['User ${index + 1}']!.elementAt(0),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              userReview['User ${index + 1}']!.elementAt(1),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  Icons.star,
                                  color: i <
                                          userReview['User ${index + 1}']!
                                              .elementAt(2)
                                      ? primaryColor
                                      : Colors.white,
                                  size: 20,
                                ),
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }
}
