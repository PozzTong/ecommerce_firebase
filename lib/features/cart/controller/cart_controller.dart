// import 'package:get/get.dart';

// import '../../feature.dart';

// class CartController extends GetxController {
//   var cartItems = <CartModel>[].obs;
//   // Add item to cart
//   void addToCart(ShoeModel shoe) {
//     int index = cartItems.indexWhere((item) => item.id == shoe.id);

//     if (index != -1) {
//       cartItems[index].quantity += 1; // Increase quantity if item exists
//       cartItems.refresh();
//     } else {
//       cartItems.add(CartModel.fromShoeModel(shoe)); // Add new item
//     }

//     Get.snackbar("Added to Cart", "${shoe.name} added successfully!");
//   }

//   // Remove item from cart
//   void removeFromCart(String id) {
//     cartItems.removeWhere((item) => item.id == id);
//     Get.snackbar("Removed", "Item removed from cart");
//   }

//   // Increase item quantity
//   void increaseQuantity(String id) {
//     int index = cartItems.indexWhere((item) => item.id == id);
//     if (index != -1) {
//       cartItems[index].quantity++;
//       cartItems.refresh();
//     }
//   }

//   // Decrease item quantity (removes item if quantity becomes 0)
//   void decreaseQuantity(String id) {
//     int index = cartItems.indexWhere((item) => item.id == id);
//     if (index != -1) {
//       if (cartItems[index].quantity > 1) {
//         cartItems[index].quantity--;
//       } else {
//         cartItems.removeAt(index);
//       }
//       cartItems.refresh();
//     }
//   }

//   // Calculate total price of items in cart
//   double get totalPrice =>
//       cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

//   // Get total cart item count
//   int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
// }
