import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class ShoeController extends GetxController {
  var shoe = <ShoeModel>[].obs;
  var pro = <ProModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShoeModels();
    fetchProModels();
  }

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading.value = shouldLoad;
    update(); // Notify the UI

    try {
      await fetchShoeModels();
      await fetchProModels();
      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchShoeModels() async {
    try {
      var querySnapshot = await FirebaseCollection.getShoeData();
      shoe.value = querySnapshot.docs
          .map((doc) => ShoeModel.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchProModels() async {
    try {
      var querySnapshot = await FirebaseCollection.getProData();
      pro.value = querySnapshot.docs
          .map((doc) => ProModel.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching products: $e");
      }
      isLoading.value = false;
      update();
    }
  }
}

class AppKeyConfig {
  static const proKey = 'promodel';
  static const shoeKey = 'shoe_model';
}

class FirebaseCollection {
  static Future<QuerySnapshot<Map<String, dynamic>>> getShoeData() async {
    return FirebaseFirestore.instance.collection(AppKeyConfig.shoeKey).get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getProData() async {
    return FirebaseFirestore.instance.collection(AppKeyConfig.proKey).get();
  }
}
