import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/common/common.dart';
import '/core/core.dart';

class LocalizationController extends GetxController {
  final SharedPreferences sharedPreferences;
  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(LocalString.appLanguages[0].languageCode,
      LocalString.appLanguages[0].countryCode);
  bool _isLtr = true;
  final List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences.getString('language_code') ??
          LocalString.appLanguages[0].languageCode,
      sharedPreferences.getString('country_code') ??
          LocalString.appLanguages[0].countryCode,
    );
    _isLtr = _locale.languageCode != 'ar';
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString('language_code', locale.languageCode);
    sharedPreferences.setString('country_code', locale.countryCode ?? '');
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
