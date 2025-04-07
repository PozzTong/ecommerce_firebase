import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';

class DrawersController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Log Out Method
  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth.signOut();

      Get.offAllNamed(
        RouteHelper.loginScreen,
      );
      await sharedPreferences.remove(SharedPreferenceHelper.rememberMeKey);
      await sharedPreferences.remove(SharedPreferenceHelper.accessTokenKey);
    } catch (e) {
      // Handle error

      // ignore: use_build_context_synchronously
      print(e);
    }
  }
}
