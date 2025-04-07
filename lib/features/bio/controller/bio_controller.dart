import 'package:ecomerce_app/core/core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BioController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final RxString authorized = 'Not Authorized'.obs;
  RxBool isAuthenticating = false.obs;
  var enteredNumber = "".obs;
  RxBool isAuthenticated = false.obs; // New flag

  // @override
  // void onInit() {
  //   super.onInit();
  //   authenticate();
  // }

  Future<void> authenticate() async {
    if (isAuthenticated.value) return;

    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating...';

      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate using biometrics',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (authenticated) {
        authorized.value = 'Authorized';
        isAuthenticated.value = true;
        Get.offAllNamed(RouteHelper.bottomNavbar);
      } else {
        authorized.value = 'Not Authorized';
      }
    } on PlatformException {
      authorized.value = 'Error during authentication';
    } finally {
      isAuthenticating.value = false;
    }
  }

  void onNumberPressed(String number) {
    if (enteredNumber.value.length < 4) {
      enteredNumber.value += number;
    }
    update();
  }

  void ondelete() {
    if (enteredNumber.isNotEmpty) {
      enteredNumber.value =
          enteredNumber.substring(0, enteredNumber.value.length - 1);
    }
    update();
  }
}
