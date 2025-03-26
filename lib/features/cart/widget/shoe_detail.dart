import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class ShoeDetail extends StatefulWidget {
  const ShoeDetail({super.key});
  @override
  State<ShoeDetail> createState() => _ShoeDetailState();
}

class _ShoeDetailState extends State<ShoeDetail> {
  List<String> sizes = [
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
  ];
  int? _selectedIndex;
  Color? colors;
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String id = arguments['id'];
    final String image = arguments['image'];
    final String name = arguments['name'];
    final double price = arguments['price'];
    final ShoeModel shoe = arguments['shoe'];
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            'Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.toggleFavorite(shoe);
              },
              icon: Icon(
                Icons.favorite,
                size: 24,
                color: controller.isFavorite(id) ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: id, // Same tag for smooth animation
                child: Container(
                  margin: EdgeInsets.all(8),
                  // height: size.height * 0.3,
                  height: size.width * 0.75,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
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
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      sizes.length,
                      (index) => Padding(
                        padding: EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // _selectedIndex = index;
                              _selectedIndex =
                                  (_selectedIndex == index) ? -1 : index;
                            });
                          },
                          child: Card(
                            color: _selectedIndex == index
                                ? Colors.red
                                : Colors.grey.withOpacity(0.5),
                            elevation: 5,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  sizes[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _selectedIndex == index
                                        ? Colors.white
                                        : colors,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '$price\$',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 16, right: 4),
                      width: size.width * 0.42,
                      height: size.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 16, left: 4),
                      width: size.width * 0.42,
                      height: size.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ReadMoreText(
                    text:
                        """More Air, less bulk. The Dn8 takes our Dynamic Air system and condenses it into a sleek, low-profile package. Powered by eight pressurised Air tubes, it gives you a responsive sensation with every step. Enter an unreal experience of movement."""),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          controller.addToCart(shoe);
                          Get.snackbar(
                            name,
                            'Qty: ${controller.totalItems}',
                            // onTap: (snack) =>
                            // Get.toNamed(RouteHelper.cartPage),
                          );
                        },
                        icon: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.13,
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
