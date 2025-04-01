import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
class BiometricService extends GetxService {
  final LocalAuthentication auth = LocalAuthentication();
  final RxBool isSupported = false.obs;
  final RxBool canCheckBiometrics = false.obs;
  final RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;
  final RxString authorized = 'Not Authorized'.obs;
  final RxBool isAuthenticating = false.obs;

  Future<BiometricService> init() async {
    isSupported.value = await auth.isDeviceSupported();
    return this;
  }

  Future<void> checkBiometrics() async {
    try {
      canCheckBiometrics.value = await auth.canCheckBiometrics;
    } on PlatformException {
      canCheckBiometrics.value = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      availableBiometrics.value = await auth.getAvailableBiometrics();
    } on PlatformException {
      availableBiometrics.clear();
    }
  }

  Future<void> authenticate({bool biometricOnly = false}) async {
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating...';
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate using biometrics',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );
      authorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    } on PlatformException {
      authorized.value = 'Error during authentication';
    } finally {
      isAuthenticating.value = false;
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating.value = false;
  }
}
