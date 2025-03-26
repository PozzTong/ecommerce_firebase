import 'package:ecomerce_app/core/core.dart';
import 'package:ecomerce_app/features/cart/cart.dart';
import 'package:ecomerce_app/features/dashboard/controller/product_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/service/di_service.dart' as services;
// import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.put(() => ShoeController());
  Get.put(CartController());
  await Firebase.initializeApp();

  // ignore: unused_local_variable
  Map<String, Map<String, String>> language = await services.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fire Base',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(milliseconds: 200),
      navigatorKey: Get.key,
      getPages: RouteHelper().routes,
      // initialBinding:,
      initialRoute: RouteHelper.splashScreen,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      // locale: localizeController.locale,
      // translations: Messages(languages: languages),
      // fallbackLocale: Locale(
      //   localizeController.locale.languageCode,
      //   localizeController.locale.countryCode,
      // ),
    );
  }
}
