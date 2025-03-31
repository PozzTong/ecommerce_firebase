import 'dart:async';
import 'package:ecomerce_app/core/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
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

  final ShoeController shoeController = Get.find<ShoeController>();

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shoeController.selectedCategorys("man");
      shoeController.update();
    });
    Future.delayed(Duration.zero, () {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) {
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
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    color = isDarkMode ? Colors.black : Colors.white;
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ShoeController>(
      builder: (shoeController) {
        return GetBuilder<CartController>(builder: (cartController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                Badges(
                  icon: Icons.notifications_active_outlined,
                  size: 30,
                  color: colors!,
                  text: '',
                  isShow: false,
                  tap: () {
                    // Get.toNamed(RouteHelper.bottomNavbar);
                  },
                )
              ],
            ),
            drawer: Drawers(),
            body: RefreshIndicator(
              onRefresh: () async {
                await shoeController.initialData();
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
                                                      BorderRadius.circular(
                                                          5))),
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
                          var entries = mapCate.entries
                              .toList()[index]
                              .value
                              .entries
                              .first;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                catIndex = index;
                                shoeController.selectedCategorys(entries.key);
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
                        itemCount: shoeController.filteredShoe.length,
                        itemBuilder: (context, index) {
                          var product = shoeController.filteredShoe[index];
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
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  RouteHelper.shoeDetail,
                                                  arguments: {
                                                    'id': product.id,
                                                    'image': product.image,
                                                    'price': product.price,
                                                    'name': product.name,
                                                    'cate': product.cate,
                                                    'shoe': product
                                                  });
                                            },
                                            child: Hero(
                                              tag: product.id,
                                              child: Container(
                                                width: size.width * 0.5,
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
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                cartController
                                                    .toggleFavorite(product);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                size: 24,
                                                color: cartController
                                                        .isFavorite(product.id)
                                                    ? Colors.redAccent
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                cartController
                                                    .addToCart(product);

                                                Get.snackbar(
                                                  product.name,
                                                  'Add to Cart Successfully',
                                                  duration: Duration(
                                                      seconds:
                                                          2), // Show for 2 seconds
                                                  // backgroundColor: Colors.black
                                                  //     .withOpacity(0.8),
                                                  // colorText: Colors.white,
                                                  margin: EdgeInsets.all(10),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.blue,
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
                                        maxLines: 2,
                                        style: TextStyle(
                                          // color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 0,
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
                                              Text(
                                                '⭐ 4.8',
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
        });
      },
    );
  }
}
