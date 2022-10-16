import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../styles/colors.dart';
import '../../widgets/custom_rounded_button.dart';
import '../../widgets/home_drawer.dart';

class HomePageLoading extends StatefulWidget {
  const HomePageLoading({Key? key}) : super(key: key);

  @override
  State<HomePageLoading> createState() => _HomePageLoadingState();
}

class _HomePageLoadingState extends State<HomePageLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const CustomShimmer(
          height: 25,
          width: 100,
        ),
      ),
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 30,
            left: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomShimmer(
                      height: 30,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child:
                          Image.asset("images/avatar/ele_scooter_avatar.png"),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 20.0,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(
                                flex: 1,
                                child: CustomShimmer(
                                  height: 30,
                                  width: 120,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: CustomShimmer(
                                  height: 30,
                                  width: 120,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(
                                flex: 1,
                                child: CustomShimmer(
                                  height: 30,
                                  width: 120,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: CustomShimmer(
                                  height: 30,
                                  width: 120,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.home,
                        color: primaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.bolt,
                        size: 20,
                        color: primaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRoundedButton(
                onPressed: () {},
                title: "Search",
                backgroundColor: primaryColor,
                textColor: darkColor,
                elevation: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.black38,
        highlightColor: darkColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
