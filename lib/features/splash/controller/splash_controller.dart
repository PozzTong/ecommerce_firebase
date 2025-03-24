import 'package:ecomerce_app/core/core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  bool isLoading = true, noInternet = false;

  gotoNextPage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool remember =
        sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ??
            false;
    bool isOnBoard =
        sharedPreferences.getBool(SharedPreferenceHelper.onboardKey) ?? false;

    noInternet = false;
    update();
    getData(remember, isOnBoard);
    // print('remember:${remember}');
  }

  void getData(bool isRemember, bool isOnBoard) async {
    isLoading = false;
    update();

    if (isOnBoard == true) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    } else {
      if (isRemember) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.dashboardScreen);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.loginScreen);
        });
      }
    }
  }
}
