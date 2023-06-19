import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superlotto/Constant/ApiConstant.dart';

class LocalizationProvider extends ChangeNotifier {
   SharedPreferences? sharedPreferences;

  LocalizationProvider() {
    _loadCurrentLanguage();
  }

  Locale _locale = Locale(ApiConst.languages[0].languageCode, ApiConst.languages[0].countryCode);
  Locale get locale => _locale;

  void setLanguage(Locale locale) {
    _locale = locale;
    _saveLanguage(_locale);
    notifyListeners();
  }

   _loadCurrentLanguage() async {
    sharedPreferences =await SharedPreferences.getInstance();
    _locale = Locale(sharedPreferences?.getString(ApiConst.LANGUAGE_CODE) ?? ApiConst.languages[0].languageCode,
        sharedPreferences?.getString(ApiConst.COUNTRY_CODE) ?? ApiConst.languages[0].countryCode);
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences?.setString(ApiConst.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences?.setString(ApiConst.COUNTRY_CODE, locale.countryCode??"");
  }
}