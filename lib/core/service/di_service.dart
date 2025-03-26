import 'package:ecomerce_app/features/cart/cart.dart';
import 'package:ecomerce_app/features/dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => CartController());
  Get.lazyPut(()=>ShoeController(),fenix: true);

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};
  return language;
}
