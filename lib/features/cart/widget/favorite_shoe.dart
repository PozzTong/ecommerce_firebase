import 'package:ecomerce_app/features/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteShoe extends StatefulWidget {
  const FavoriteShoe({super.key});
  @override
  State<FavoriteShoe> createState() => _FavoriteShoeState();
}

class _FavoriteShoeState extends State<FavoriteShoe> {
  // final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Favorite Shoe'.toUpperCase(),
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.favorite.length,
            itemBuilder: (context, index) {
              var shoe = controller.favorite[index];
              return Container(
                  margin: EdgeInsets.all(8.0),
                  height: size.height * 0.15,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.15,
                        width: size.height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: NetworkImage(
                              shoe.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.toggleFavorite(shoe);
                              },
                              icon: controller.isFavorite(shoe.id)
                                  ? Icon(
                                      Icons.bookmark,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.bookmark_outline),
                            ),
                          ],
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
                            Text(shoe.name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text(
                              '${shoe.price}\$',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            // Spacer(),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.addToCart(shoe);
                          Get.snackbar(
                            shoe.name,
                            'Add to Cart Successfully',
                            duration: Duration(seconds: 2), // Show for 2 seconds
                            margin: EdgeInsets.all(10),
                          );
                        },
                        icon: Icon(
                          Icons.add_shopping_cart_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ));
            });
      }),
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
}
