import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/user.dart';

class Settings extends ChangeNotifier {

  static String languageCode = 'en';

  bool isInit = false;

  Locale _locale;

  Locale get locale => _locale;

  String _country;

  String get country => _country;

  User _user;

  User get user => _user;

  Box box;

  String _fontFamily;
  String get fontFamily => _fontFamily;


  void init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('settings');

    final lc = box.get('language_code');
    if (lc != null) {
      _locale = Locale(lc);
      languageCode = _locale.languageCode;
      setFont(languageCode);
    } else {
      _locale = Locale('en');
      setFont('en');
    }

    final u = box.get('user');
    if (u != null){
      _user = User.fromJson(u);
      Request.accessToken = _user.accessToken;
    }

    isInit = true;
    notifyListeners();
  }

  void setFont(String languageCode){
    final llocale = languageCode.toLowerCase();
    switch(llocale){
      case 'fa':
        _fontFamily = 'yekan';
        break;

      default:
        _fontFamily = 'raleway';
    }
  }

  void setLanguageCode(String code) {
    box.put('language_code', code);
    _locale = Locale(code);
    languageCode = _locale.languageCode;
    setFont(languageCode);
    notifyListeners();
  }


  String getInitRoute() {
    return null;
    // final askedLang = box.get('asked_lang');
    // final askedLogin = box.get('asked_login');
    //
    // return askedLang == null || !askedLang
    //     ? Routes.language
    //     : (askedLogin == null || !askedLogin ? Routes.login : Routes.home);
  }

  void setAskedLanguage() {
    box.put('asked_lang', true);
  }

  void setAskedLogin() {
    box.put('asked_login', true);
  }

}
