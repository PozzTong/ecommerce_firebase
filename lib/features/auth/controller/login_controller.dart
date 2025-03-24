import 'package:ecomerce_app/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  String? email;
  String? password;

  bool remember = false, isSubmitLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginController();

  @override
  void onInit() {
    super.onInit();
    _checkForExistingSession();
  }

  Future<void> _checkForExistingSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? rememberMe =
        sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey);
    String? token =
        sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);

    if (rememberMe == true && token != null) {
     
      Get.offAllNamed(RouteHelper.dashboardScreen);
    }
  }

  Future<void> checkAndGotoNextStep({required String token}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (remember) {
      await sharedPreferences.setBool(
          SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(
          SharedPreferenceHelper.rememberMeKey, false);
    }

    await sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey, token);
    Get.offAllNamed(RouteHelper.dashboardScreen);
    if (remember) {
      changeRememberMe();
    }
  }

  void logIn() async {
    isSubmitLoading = true;
    update();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Get Firebase ID Token
        String? token = await userCredential.user?.getIdToken();

        checkAndGotoNextStep(token: token ?? '');
        if (kDebugMode) {
          print('Firebase ID Token: $token');
        }

        Get.offAndToNamed(RouteHelper.dashboardScreen);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect password.');
      } else {
        Get.snackbar('Error', e.message ?? 'Something went wrong!');
      }
    } finally {
      isSubmitLoading = false;
      update();
    }
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }
}
