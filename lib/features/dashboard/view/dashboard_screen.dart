import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Color? colors, color;

  Map<String, Map<String, String>> mapCate = {
    "Man's Shoes": {'man': "assets/shoe/men_svg.png"},
    "Woman's Shoes": {'woman': "assets/shoe/women_svg.png"},
    "Sport's Shoes": {'sport': "assets/shoe/sport_svg.png"},
    "Mountain's Shoes": {'mountain': "assets/shoe/mountain_svg.png"},
    "Running Shoes": {'run': "assets/shoe/running_svg.png"},
  };

  final ShoeController controller = Get.put(ShoeController());
  // final CartController cartController = Get.put(CartController());
  List<String> banner = [
    'assets/shoe/shoe01.png',
    'assets/shoe/nike.png',
    'assets/shoe/joden.png',
    'assets/shoe/nike_fire.png',
  ];
  int catIndex = 0;
  int currentIndex = 0;
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedCategorys("man");
      controller.update();
    });
    Future.delayed(Duration.zero, () {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (currentIndex < banner.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(currentIndex,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ShoeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                icon: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: colors!,
                    ),
                  ),
                  child: Icon(
                    Icons.grid_view_outlined,
                  ),
                ),
              );
            }),
            title: Text('Explore'),
            centerTitle: true,
            actions: [
              // Badges(
              //   icon: Icons.notifications_active_outlined,
              //   size: 30,
              //   color: colors!,
              //   text: cartController.totalItems.toString(),
              //   isShow: cartController.cartItems.isNotEmpty,
              //   tap: () {},
              // )
            ],
          ),
          drawer: Drawers(),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.initialData();
            },
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.5,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: banner.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      physics: PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: 25,
                            left: 8,
                            right: 8,
                            bottom: 15,
                          ),
                          height: size.width * 0.42,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 20,
                                top: 20,
                                bottom: 10,
                                child: SizedBox(
                                  width: size.width * 0.45,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Flat 50% Discount on your first order.',
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {},
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(color: colors),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                bottom: -25,
                                top: -20,
                                child: Image.asset(
                                  banner[index],
                                  // height: 100,
                                  scale: 1.2,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'view all'.toUpperCase(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: size.width * 0.12,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(mapCate.length, (index) {
                        var entry = mapCate.entries.toList()[index];
                        var entries =
                            mapCate.entries.toList()[index].value.entries.first;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              catIndex = index;
                              controller.selectedCategorys(entries.key);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: catIndex == index
                                  ? Colors.red
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(4),
                                  height: size.width * 0.11,
                                  width: size.width * 0.11,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors,
                                  ),
                                  child: Image.asset(
                                    entries.value,
                                    color: color,
                                  ),
                                ),
                                if (catIndex == index)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 6 / 8,
                      ),
                      itemCount: controller.filteredShoe.length,
                      itemBuilder: (context, index) {
                        var product = controller.filteredShoe[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: size.width / 2,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                product.image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              // cartController.addToCart(product);
                                              // print('object');
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          '${product.price}\$',
                                          style: TextStyle(
                                            // color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              // color: Colors.white,
                                            ),
                                            Text(
                                              '4.8',
                                              style: TextStyle(
                                                // color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Badges extends StatelessWidget {
  const Badges({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
    required this.text,
    required this.isShow,
    required this.tap,
  });

  final IconData icon;
  final double size;
  final Color color;
  final String text;
  final bool isShow;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tap(),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(
          top: -10,
          end: -12,
        ),
        showBadge: isShow,
        ignorePointer: false,
        onTap: () {},
        badgeContent: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        badgeAnimation: badges.BadgeAnimation.rotation(
          animationDuration: Duration(seconds: 1),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInCubic,
        ),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: Colors.red,
          padding: EdgeInsets.all(4),
          borderRadius: BorderRadius.circular(4),
          // borderSide: BorderSide(color: Colors.white, width: 2),
          elevation: 0,
        ),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
