import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/core/core.dart';
import 'package:ecomerce_app/features/account/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AcController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final RxString authorized = 'Not Authorized'.obs;
  RxBool isAuthenticating = false.obs;
  RxBool isBalanceVisible = false.obs;

  var user = <UserModel>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> authenticate() async {
    try {
      isAuthenticating.value = true;
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(useErrorDialogs: false),
      );

      if (didAuthenticate) {
        isBalanceVisible.value = true;
        authorized.value = 'Authorized';
      } else {
        isBalanceVisible.value = false;
        authorized.value = 'Not Authorized';
      }
    } on PlatformException catch (e) {
      isBalanceVisible.value = false;
      if (e.code == auth_error.notAvailable) {
        authorized.value = 'Biometric authentication not available';
      } else if (e.code == auth_error.notEnrolled) {
        authorized.value = 'No biometrics enrolled';
      } else {
        authorized.value = 'Authentication error';
      }
    } finally {
      isAuthenticating.value = false;
    }
  }

  void hideBalance() {
    isBalanceVisible.value = false;
  }

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading.value = shouldLoad;
    update();
    try{
      await fetchUser();
      isLoading.value=false;
      update();
    }catch(e){
      if (kDebugMode) {
        print('error:$e');
      }
       isLoading.value = false;
      update();
    }
  }

  Future<void> fetchUser() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      querySnapshot = await FirebaseCollection.getUser();
      user.value = querySnapshot.docs
          .map((d) => UserModel.fromJson({'id': d.id, ...d.data()}))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('error:$e');
      }
      isLoading.value = false;
      update();
    }
  }
}
