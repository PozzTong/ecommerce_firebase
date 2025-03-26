import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class ShoeCart extends StatefulWidget {
  const ShoeCart({super.key});
  @override
  State<ShoeCart> createState() => _ShoeCartState();
}

class _ShoeCartState extends State<ShoeCart> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Bag',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${controller.totalItems} items',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          body: ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                var shoe = controller.cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Slidable(
                    key: const ValueKey(0),
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      dismissible: DismissiblePane(onDismissed: () {
                        controller.removeonceFromCart(shoe.shoe);
                      }), // scroll to close
                      motion: const DrawerMotion(),
                      extentRatio: 0.25,
                      openThreshold: 0.2,
                      closeThreshold: 0.2,
                      children: [
                        SlidableAction(
                          spacing: 4,
                          flex: 1,
                          padding: EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(10),
                          // spacing: 4,
                          onPressed: (_) {
                            controller.removeonceFromCart(shoe.shoe);
                          },
                          backgroundColor: Colors.redAccent,
                          // foregroundColor: Colors.white,
                          icon: Icons.delete_outline,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      height: 100,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(4),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  shoe.shoe.image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  capitalizeEachWord(shoe.shoe.name),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${controller.getItemTotalPrice(shoe.shoe)}\$',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                // Spacer(),
                                Row(
                                  children: [
                                    btn(
                                      icon: Icons.horizontal_rule,
                                      bgColor: Colors.grey,
                                      tap: () {
                                        controller.removeFromCart(shoe.shoe);
                                      },
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 25,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text('${shoe.quantity}'),
                                    ),
                                    btn(
                                      icon: Icons.add,
                                      bgColor: Colors.amber,
                                      tap: () {
                                        controller.addToCart(shoe.shoe);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.toggleFavorite(shoe.shoe);
                              },
                              icon: controller.isFavorite(shoe.shoe.id)
                                  ? Icon(
                                      Icons.bookmark,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.bookmark_outline)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget btn({
    required IconData icon,
    required Color bgColor,
    required Function() tap,
  }) {
    return GestureDetector(
      onTap: () => tap(),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
        ),
        child: Icon(icon),
      ),
    );
  }

  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ') // Split string into words
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
