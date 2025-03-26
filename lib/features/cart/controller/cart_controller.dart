import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/core.dart';
import '../../feature.dart';

class CartController extends GetxController {
  var cartItems = <CartModel>[].obs;
  var shoeItems = <ShoeModel>[].obs;
  var favorite = <ShoeModel>[].obs;

  @override
  void onInit() {
    loadCart();
    loadFavorites();
    super.onInit();
  }

  void loadCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? cartJson =
        sharedPreferences.getStringList(SharedPreferenceHelper.cart);
    if (cartJson != null) {
      cartItems.value =
          cartJson.map((c) => CartModel.fromJson(jsonDecode(c))).toList();
    }
  }

  void saveCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? cartJson =
        cartItems.map((c) => jsonEncode(c.toJson())).toList();
    await sharedPreferences.setStringList(
        SharedPreferenceHelper.cart, cartJson);
    update();
  }

  void saveFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favJson = favorite.map((f) => jsonEncode(f.toJson())).toList();
    await sharedPreferences.setStringList(
        SharedPreferenceHelper.favorite, favJson);
  }

  Future<void> loadFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? favJson =
        sharedPreferences.getStringList(SharedPreferenceHelper.favorite);
    if (favJson != null) {
      favorite.value =
          favJson.map((s) => ShoeModel.fromJson(jsonDecode(s))).toList();
    }
  }

  void toggleFavorite(ShoeModel shoe) {
    if (isFavorite(shoe.id)) {
      favorite.removeWhere((item) => item.id == shoe.id);
    } else {
      favorite.add(shoe);
    }
    saveFavorites();
    update();
  }

  bool isFavorite(String id) {
    return favorite.any((shoe) => shoe.id == id);
  }

  // Add item to cart
  void addToCart(ShoeModel shoe) {
    if (shoe.qty > 0) {
      int index = cartItems.indexWhere((item) => item.shoe.id == shoe.id);
      if (index != -1) {
        cartItems[index].quantity++;
        shoe.decreaseStock(1);
      } else {
        cartItems.add(CartModel(shoe: shoe, quantity: 1));
      }
    } else {
      Get.snackbar("Out of Stock", '${shoe.name} is not available');
    }
    saveCart();
    update();
  }

  void removeFromCart(ShoeModel shoe) {
    int index = cartItems.indexWhere((item) => item.shoe.id == shoe.id);
    if (index != 1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        shoe.increaseStock(1);
      } else {
        cartItems.removeAt(index);
        shoe.increaseStock(1);
      }
    }
    saveCart();
    update();
  }

  void removeonceFromCart(ShoeModel shoe) {
    int index = cartItems.indexWhere((item) => item.shoe.id == shoe.id);
    if (index != -1) {
      shoe.increaseStock(cartItems[index].quantity);
      cartItems.removeAt(index);
    }
    saveCart();
    update();
  }

  double getItemTotalPrice(ShoeModel shoe) {
    int index = cartItems.indexWhere((item) => item.shoe.id == shoe.id);
    return index != -1
        ? cartItems[index].shoe.price * cartItems[index].quantity
        : 0;
  }

  bool isInCart(ShoeModel shoe) {
    return cartItems.any((p) => p.shoe.id == shoe.id);
  }

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount =>
      cartItems.fold(0, (sum, item) => sum + (item.shoe.price * item.quantity));

  void updateProductQty(ShoeModel shoe, int newQty) {
    int index = cartItems.indexWhere((p) => p.shoe.id == shoe.id);
    if (index != 1) {
      if (newQty > 0 && newQty <= shoe.qty) {
        cartItems[index].quantity = newQty;
        shoe.decreaseStock(newQty - cartItems[index].quantity);
        update();
      } else {
        Get.snackbar("Invalid Quantity", "Please enter a valid quantity.");
      }
    }
    update();
  }
}
