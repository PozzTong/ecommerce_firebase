import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/core.dart';

class FirebaseCollection {
  static Future<QuerySnapshot<Map<String, dynamic>>> getShoeData(
      {String? cate}) async {
// return FirebaseFirestore.instance.collection(AppKeyConfig.shoeKey) .where('cate', isEqualTo: cate) .get();
    CollectionReference<Map<String, dynamic>> collectionRef;

    collectionRef = FirebaseFirestore.instance.collection(AppKeyConfig.shoeKey);

    if (cate != null) {
      return collectionRef.orderBy('id').where('cate', isEqualTo: cate).get();
    } else {
      return collectionRef.orderBy('id').get();
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getProData() async {
    return FirebaseFirestore.instance.collection(AppKeyConfig.proKey).get();
  }
}
