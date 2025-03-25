import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class ShoeController extends GetxController {
  var shoe = <ShoeModel>[].obs;
  var pro = <ProModel>[].obs;
  var isLoading = true.obs;
  List<ShoeModel> filteredShoe = [];//filter 

  @override
  void onInit() {
    super.onInit();
    fetchShoeModels();
    fetchProModels();
    // to call fiter when start
    fetchShoeModels().then((_) {
      selectedCategorys("man");
    });
  }

  void selectedCategorys(String category) {
    filteredShoe = shoe.where((s) => s.cate == category).toList();
    update();
  }

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading.value = shouldLoad;
    update();
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

  Future<void> fetchShoeModels({String? cate}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      // querySnapshot = await FirebaseCollection.getShoeData(cate: cate!);
      if (cate == null) {
        querySnapshot = await FirebaseCollection.getShoeData();
      } else {
        querySnapshot = await FirebaseCollection.getShoeData(cate: cate);
      }
       shoe.value = querySnapshot.docs
          .map((doc) => ShoeModel.fromJson({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();
      if (filteredShoe.isEmpty) {
        selectedCategorys("man");
      }
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
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      querySnapshot = await FirebaseCollection.getProData();
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
