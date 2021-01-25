import 'package:flutter/material.dart';

abstract class Language {
  static Language of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  Locale get locale;
  String get languageName;
  String get unknownError;
  String get tryAgain;
  String get noItem;
}
