import 'package:wood/core/localization/language/en.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/localization/language/fa.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Language> {
  const AppLocalizationsDelegate();

  @override
  // bool isSupported(Locale locale) => ['ar', 'fa', 'en'].contains(locale.languageCode);
  bool isSupported(Locale locale) => true;

  @override
  Future<Language> load(Locale locale) {

    switch(locale.languageCode){
      case 'fa':
        return SynchronousFuture<Language>(LanguageFa(locale: locale));

      default:
        return SynchronousFuture<Language>(LanguageEn(locale: locale));
    }


  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}