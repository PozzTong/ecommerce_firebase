
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/feature.dart';

class RouteHelper {
  static const String loginScreen = '/login_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String splashScreen = '/splash_screen';
  static const String shoeDetail = '/shoe_detail';
  static const String favShoe = '/favorite_shoe';
  static const String shoeCart = '/shoe_cart';
  static const String bottomNavbar='/bottom_navbar';

  List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
      name: shoeDetail,
      page: () => ShoeDetail(),
      transition: Transition.rightToLeft,
      curve: Curves.easeInOut,
    ),
    GetPage(name: favShoe, page: () => FavoriteShoe()),
    GetPage(
      name: shoeCart,
      page: () => ShoeCart(),
      transition: Transition.leftToRight,
    ),
    GetPage(name: bottomNavbar, page:()=>BottomNavbar()),
  ];
}
