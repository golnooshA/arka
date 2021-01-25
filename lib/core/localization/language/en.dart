import 'package:flutter/material.dart';
import 'package:wood/core/localization/language.dart';

class LanguageEn extends Language {
  final Locale locale;

  LanguageEn({this.locale});

  final String languageName = 'English';
  final String unknownError = 'Something went wrong';
  final String tryAgain = 'Try again';
  final String noItem = 'Data not found';
}
