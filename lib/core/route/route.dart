
import 'package:get/get.dart';

import '../../features/feature.dart';

class RouteHelper {
  static const String loginScreen= '/login_screen';
  static const String dashboardScreen='/dashboard_screen';
  static const String splashScreen='/splash_screen';

  List<GetPage> routes =[
    GetPage(name: loginScreen, page:()=> LoginScreen()),
    GetPage(name: dashboardScreen, page:()=>DashboardScreen()),
    GetPage(name: splashScreen, page:()=>SplashScreen()),
  ];
}