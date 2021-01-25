import 'package:flutter/material.dart';
import 'package:wood/core/localization/language.dart';

class LanguageFa extends Language {
  final Locale locale;

  LanguageFa({this.locale});

  final String languageName = 'فارسی';
  final String unknownError = 'خطا در ارسال/دریافت اطلاعات';
  final String tryAgain = 'تلاش دوباره';
  final String noItem = 'اطلاعات یافت نشد';
}
