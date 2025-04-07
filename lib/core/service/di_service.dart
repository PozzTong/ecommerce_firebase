import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/feature.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => CartController());
  Get.lazyPut(() => ShoeController(), fenix: true);
  Get.lazyPut(
    () => DateSelectedController(
      service: SqflitService(),
      notiService: NotiService(),
    ),
    fenix: true,
  );
  Get.lazyPut(() => NotiService());
  Get.lazyPut(() => SqflitService());
  Get.lazyPut(() => BioController());
  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};
  return language;
}
