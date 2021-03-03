import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/data/province.dart';
import 'package:wood/data/city.dart';
import 'package:wood/data/result.dart';
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


  final List<Province> provinces = [
    Province(name: 'آذربایجان شرقی', cities: [
      City(name: 'آذرشهر'),
      City(name: 'اسکو'),
      City(name: 'اهر'),
      City(name: 'بستان‌آباد'),
      City(name: 'بناب'),
      City(name: 'تبریز'),
      City(name: 'جلفا'),
      City(name: 'چاراویماق'),
      City(name: 'سراب'),
      City(name: 'شبستر'),
      City(name: 'عجب‌شیر'),
      City(name: 'کلیبر'),
      City(name: 'مراغه'),
      City(name: 'مرند'),
      City(name: 'ملکان'),
      City(name: 'میانه'),
      City(name: 'ورزقان'),
      City(name: 'هریس'),
      City(name: 'هشترود'),
    ]),
    Province(name: 'آذربایجان غربی', cities: [
      City(name: 'ارومیه'),
      City(name: 'اشنویه'),
      City(name: 'بوکان'),
      City(name: 'پیرانشهر'),
      City(name: 'تکاب'),
      City(name: 'چالدران'),
      City(name: 'خوی'),
      City(name: 'سردشت'),
      City(name: 'سلماس'),
      City(name: 'شاهین‌دژ'),
      City(name: 'ماکو'),
      City(name: 'مهاباد'),
      City(name: 'میاندوآب'),
      City(name: 'نقده'),
    ]),
    Province(name: 'اردبیل', cities: [
      City(name: 'اردبیل'),
      City(name: 'بیله‌سوار'),
      City(name: 'پارس‌آباد'),
      City(name: 'خلخال'),
      City(name: 'کوثر'),
      City(name: 'گرمی'),
      City(name: 'مشگین‌شهر'),
      City(name: 'نمین'),
      City(name: 'نیر'),
    ]),
    Province(name: 'اصفهان', cities: [
      City(name: 'آران و بیدگل'),
      City(name: 'اردستان'),
      City(name: 'اصفهان'),
      City(name: 'برخوار و میمه'),
      City(name: 'تیران و کرون'),
      City(name: 'چادگان'),
      City(name: 'خمینی‌شهر'),
      City(name: 'خوانسار'),
      City(name: 'سمیرم'),
      City(name: 'شهرضا'),
      City(name: 'سمیرم سفلی'),
      City(name: 'فریدن'),
      City(name: 'فریدون‌شهر'),
      City(name: 'فلاورجان'),
      City(name: 'کاشان'),
      City(name: 'گلپایگان'),
      City(name: 'لنجان'),
      City(name: 'مبارکه'),
      City(name: 'نائین'),
      City(name: 'نجف‌آباد'),
      City(name: 'نطنز'),
    ]),
    Province(name: 'ایلام', cities: [
      City(name: 'آبدانان'),
      City(name: 'ایلام'),
      City(name: 'ایوان'),
      City(name: 'دره‌شهر'),
      City(name: 'دهلران'),
      City(name: 'شیروان و چرداول'),
      City(name: 'مهران'),
    ]),
    Province(name: 'بوشهر', cities: [
      City(name: 'بوشهر'),
      City(name: 'تنگستان'),
      City(name: 'جم'),
      City(name: 'دشتستان'),
      City(name: 'دشتی'),
      City(name: 'دیر'),
      City(name: 'دیلم'),
      City(name: 'کنگان'),
      City(name: 'گناوه')
    ]),
    Province(name: 'تهران', cities: [
      City(name: 'اسلام‌شهر'),
      City(name: 'پاکدشت'),
      City(name: 'تهران'),
      City(name: 'دماوند'),
      City(name: 'رباط‌کریم'),
      City(name: 'ری'),
      City(name: 'ساوجبلاغ'),
      City(name: 'شمیرانات'),
      City(name: 'شهریار'),
      City(name: 'فیروزکوه'),
      City(name: 'کرج'),
      City(name: 'نظرآباد'),
      City(name: 'ورامین')
    ]),
    Province(name: 'چهارمحال و بختیاری', cities: [
      City(name: 'اردل'),
      City(name: 'بروجن'),
      City(name: 'شهرکرد'),
      City(name: 'فارسان'),
      City(name: 'کوهرنگ'),
      City(name: 'لردگان')
    ]),
    Province(name: 'خراسان جنوبی', cities: [
      City(name: 'بیرجند'),
      City(name: 'درمیان'),
      City(name: 'سرایان'),
      City(name: 'سربیشه'),
      City(name: 'فردوس'),
      City(name: 'قائنات'),
      City(name: 'نهبندان'),
    ]),
    Province(name: 'خراسان رضوی', cities: [
      City(name: 'بردسکن'),
      City(name: 'تایباد'),
      City(name: 'تربت جام'),
      City(name: 'تربت حیدریه'),
      City(name: 'چناران'),
      City(name: 'خلیل‌آباد'),
      City(name: 'خواف'),
      City(name: 'درگز'),
      City(name: 'رشتخوار'),
      City(name: 'سبزوار'),
      City(name: 'سرخس'),
      City(name: 'فریمان'),
      City(name: 'قوچان'),
      City(name: 'کاشمر'),
      City(name: 'کلات'),
      City(name: 'گناباد'),
      City(name: 'مشهد'),
      City(name: 'مه ولات'),
      City(name: 'نیشابور'),
    ]),
    Province(name: 'خراسان شمالی', cities: [
      City(name: 'اسفراین'),
      City(name: 'بجنورد'),
      City(name: 'جاجرم'),
      City(name: 'شیروان'),
      City(name: 'فاروج'),
      City(name: 'مانه و سملقان')
    ]),
    Province(name: 'خوزستان', cities: [
      City(name: 'آبادان'),
      City(name: 'امیدیه'),
      City(name: 'اندیمشک'),
      City(name: 'اهواز'),
      City(name: 'ایذه'),
      City(name: 'باغ‌ملک'),
      City(name: 'بندر ماهشهر'),
      City(name: 'بهبهان'),
      City(name: 'خرمشهر'),
      City(name: 'دزفول'),
      City(name: 'دشت آزادگان'),
      City(name: 'رامشیر'),
      City(name: 'رامهرمز'),
      City(name: 'شادگان'),
      City(name: 'شوش'),
      City(name: 'شوشتر'),
      City(name: 'گتوند'),
      City(name: 'لالی'),
      City(name: 'مسجد سلیمان'),
      City(name: 'هندیجان'),
    ]),
    Province(name: 'زنجان', cities: [
      City(name: 'ابهر'),
      City(name: 'ایجرود'),
      City(name: 'خدابنده'),
      City(name: 'خرمدره'),
      City(name: 'زنجان'),
      City(name: 'طارم'),
      City(name: 'ماه‌نشان')
    ]),
    Province(
        name: 'سمنان',
        cities: [City(name: 'دامغان'), City(name: 'سمنان'), City(name: 'شاهرود'), City(name: 'گرمسار'), City(name: 'مهدی‌شهر')]),
    Province(name: 'سیستان و بلوچستان', cities: [
      City(name: 'ایرانشهر'),
      City(name: 'چابهار'),
      City(name: 'خاش'),
      City(name: 'دلگان'),
      City(name: 'زابل'),
      City(name: 'زاهدان'),
      City(name: 'زهک'),
      City(name: 'سراوان'),
      City(name: 'سرباز'),
      City(name: 'کنارک'),
      City(name: 'نیک‌شهر')
    ]),
    Province(name: 'فارس', cities: [
      City(name: 'آباده'),
      City(name: 'ارسنجان'),
      City(name: 'استهبان'),
      City(name: 'اقلید'),
      City(name: 'بوانات'),
      City(name: 'پاسارگاد'),
      City(name: 'جهرم'),
      City(name: 'خرم‌بید'),
      City(name: 'خنج'),
      City(name: 'داراب'),
      City(name: 'زرین‌دشت'),
      City(name: 'سپیدان'),
      City(name: 'شیراز'),
      City(name: 'فراشبند'),
      City(name: 'فسا'),
      City(name: 'فیروزآباد'),
      City(name: 'قیر و کارزین'),
      City(name: 'کازرون'),
      City(name: 'لارستان'),
      City(name: 'لامِرد'),
      City(name: 'مرودشت'),
      City(name: 'ممسنی'),
      City(name: 'مهر'),
      City(name: 'نی‌ریز')
    ]),
    Province(
        name: 'قزوین',
        cities: [City(name: 'آبیک'), City(name: 'البرز'), City(name: 'بوئین‌زهرا'), City(name: 'تاکستان'), City(name: 'قزوین')]),
    Province(name: 'قم', cities: [City(name: 'قم')]),
    Province(name: 'کردستان', cities: [
      City(name: 'بانه'),
      City(name: 'بیجار'),
      City(name: 'دیواندره'),
      City(name: 'سروآباد'),
      City(name: 'سقز'),
      City(name: 'سنندج'),
      City(name: 'قروه'),
      City(name: 'کامیاران'),
      City(name: 'مریوان')
    ]),
    Province(name: 'کرمان', cities: [
      City(name: 'بافت'),
      City(name: 'بردسیر'),
      City(name: 'بم'),
      City(name: 'جیرفت'),
      City(name: 'راور'),
      City(name: 'رفسنجان'),
      City(name: 'رودبار جنوب'),
      City(name: 'زرند'),
      City(name: 'سیرجان'),
      City(name: 'شهر بابک'),
      City(name: 'عنبرآباد'),
      City(name: 'قلعه گنج'),
      City(name: 'کرمان'),
      City(name: 'کوهبنان'),
      City(name: 'کهنوج'),
      City(name: 'منوجان')
    ]),
    Province(name: 'کرمانشاه', cities: [
      City(name: 'اسلام‌آباد غرب'),
      City(name: 'پاوه'),
      City(name: 'ثلاث باباجانی'),
      City(name: 'جوانرود'),
      City(name: 'دالاهو'),
      City(name: 'روانسر'),
      City(name: 'سرپل ذهاب'),
      City(name: 'سنقر'),
      City(name: 'صحنه'),
      City(name: 'قصر شیرین'),
      City(name: 'کرمانشاه'),
      City(name: 'کنگاور'),
      City(name: 'گیلان غرب')
    ]),
    Province(
        name: 'کهگیلویه و بویراحمد',
        cities: [City(name: 'بویراحمد'), City(name: 'بهمئی'), City(name: 'دنا'), City(name: 'کهگیلویه'), City(name: 'گچساران')]),
    Province(name: 'گلستان', cities: [
      City(name: 'آزادشهر'),
      City(name: 'آق‌قلا'),
      City(name: 'بندر گز'),
      City(name: 'ترکمن'),
      City(name: 'رامیان'),
      City(name: 'علی‌آباد'),
      City(name: 'کردکوی'),
      City(name: 'کلاله'),
      City(name: 'گرگان'),
      City(name: 'گنبد کاووس'),
      City(name: 'مراوه‌تپه'),
      City(name: 'مینودشت')
    ]),
    Province(name: 'گیلان', cities: [
      City(name: 'آستارا'),
      City(name: 'آستانه اشرفیه'),
      City(name: 'اَملَش'),
      City(name: 'بندر انزلی'),
      City(name: 'رشت'),
      City(name: 'رضوانشهر'),
      City(name: 'رودبار'),
      City(name: 'رودسر'),
      City(name: 'سیاهکل'),
      City(name: 'شفت'),
      City(name: 'صومعه‌سرا'),
      City(name: 'طوالش'),
      City(name: 'فومَن'),
      City(name: 'لاهیجان'),
      City(name: 'لنگرود'),
      City(name: 'ماسال')
    ]),
    Province(name: 'لرستان', cities: [
      City(name: 'ازنا'),
      City(name: 'الیگودرز'),
      City(name: 'بروجرد'),
      City(name: 'پل‌دختر'),
      City(name: 'خرم‌آباد'),
      City(name: 'دورود'),
      City(name: 'دلفان'),
      City(name: 'سلسله'),
      City(name: 'کوهدشت')
    ]),
    Province(name: 'مازندران', cities: [
      City(name: 'آمل'),
      City(name: 'بابل'),
      City(name: 'بابلسر'),
      City(name: 'بهشهر'),
      City(name: 'تنکابن'),
      City(name: 'جویبار'),
      City(name: 'چالوس'),
      City(name: 'رامسر'),
      City(name: 'ساری'),
      City(name: 'سوادکوه'),
      City(name: 'قائم‌شهر'),
      City(name: 'گلوگاه'),
      City(name: 'محمودآباد'),
      City(name: 'نکا'),
      City(name: 'نور'),
      City(name: 'نوشهر')
    ]),
    Province(name: 'مرکزی', cities: [
      City(name: 'آشتیان'),
      City(name: 'اراک'),
      City(name: 'تفرش'),
      City(name: 'خمین'),
      City(name: 'دلیجان'),
      City(name: 'زرندیه'),
      City(name: 'ساوه'),
      City(name: 'شازند'),
      City(name: 'کمیجان'),
      City(name: 'محلات"')
    ]),
    Province(name: 'هرمزگان', cities: [
      City(name: 'ابوموسی'),
      City(name: 'بستک'),
      City(name: 'بندر عباس'),
      City(name: 'بندر لنگه'),
      City(name: 'جاسک'),
      City(name: 'حاجی‌آباد'),
      City(name: 'شهرستان خمیر'),
      City(name: 'رودان'),
      City(name: 'قشم'),
      City(name: 'گاوبندی'),
      City(name: 'میناب')
    ]),
    Province(name: 'همدان', cities: [
      City(name: 'اسدآباد'),
      City(name: 'بهار'),
      City(name: 'تویسرکان'),
      City(name: 'رزن'),
      City(name: 'کبودرآهنگ'),
      City(name: 'ملایر'),
      City(name: 'نهاوند'),
      City(name: 'همدان')
    ]),
    Province(name: 'یزد', cities: [
      City(name: 'ابرکوه'),
      City(name: 'اردکان'),
      City(name: 'بافق'),
      City(name: 'تفت'),
      City(name: 'خاتم'),
      City(name: 'صدوق'),
      City(name: 'طبس'),
      City(name: 'مهریز'),
      City(name: 'میبد'),
      City(name: 'یزد')
    ]),
  ];

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

  Future<Result> login(int number, String password, {bool saveToDbOnSuccess = true, Language language}) async {
    final res = await PostRequest(url: HttpConfig.url('api/login'), reqBody: {'number': number, 'password': password}).responseJson();

    switch (res.status) {
      case ReqStatus.success:
        if (res.body is! Map) {
          return Result(
              isOk: false,
              message: language.unknownError
          );
        }

        _user = User.fromJson(
          res.body['user'],
          accessToken: res.body['access_token'],
        );
        Request.accessToken = _user.accessToken;

        if (saveToDbOnSuccess) {
          box.put('user', _user.toJson());
        }
        return Result(
            isOk: true,
            message: res.body['message'] == null ? 'Done!' : res.body['message']
        );
        break;

      default:
        if (res.body is Map && res.body['message'] != null) {
          return Result(
              isOk: false,
              message: res.body['message']
          );
        } else {
          return Result(
              isOk: false,
              message: language.unknownError
          );
        }
        break;
    }
  }

  bool isSoftLogin() {
    return _user?.accessToken != null && _user?.number != null && _user?.id != null;
  }

  bool canPurchase() {
    return _user?.city != null&& _user?.province != null && _user?.address != null && _user?.postalCode != null && _user.province.trim() != ''  && _user.city.trim() != ''  && _user.address.trim() != ''  && _user.postalCode.trim() != '' ;
  }

  void uiLogout({bool notify = true}) {
    box.delete('user');
    _user = null;
    Request.accessToken = null;
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> logout({bool notify = true}) async {
    await GetRequest(
        url: HttpConfig.url('api/logout'),
        headers: {"Authorization": "Bearer ${user.accessToken}", "Content-Type": "application/json"}).responseJson();
    uiLogout(notify: notify);
  }

  void checkAndLogoutOnResponse(ResponseJson res, {bool notify = true}) {
    if (res.body is Map && res.body['is_auth'] is bool && !res.body['is_auth']) {
      uiLogout(notify: notify);
    }
  }

  Future<Result> editProfile(
      {String name, String postalCode, String address, String province, String city, bool saveToDbOnSuccess = true, Language language}) async {
    final Map<String, String> body = {};

    if (name != null) {
      body['name'] = name;
    }
    if (postalCode != null) {
      body['postal_code'] = postalCode;
    }
    if (address != null) {
      body['address'] = address;
    }
    if (province != null) {
      body['province'] = province;
    }
    if (city != null) {
      body['city'] = city;
    }

    final res = await PostRequest(
        url: HttpConfig.url('api/update-profile'),
        reqBody: body,
        headers: {"Authorization": "Bearer ${user.accessToken}", "Content-Type": "application/json"}).responseJson();

    checkAndLogoutOnResponse(res);
    switch (res.status) {
      case ReqStatus.success:
        if (res.body is! Map) {
          return Result(
              isOk: false,
              message: language.unknownError
          );
        }

        _user = User.fromJson(res.body['user'], accessToken: user.accessToken);

        if (saveToDbOnSuccess) {
          box.put('user', _user.toJson());
        }

        return Result(
            isOk: true,
            message: res.body['message'] == null ? 'Done!' : res.body['message']
        );
        break;

      default:
        if (res.body is Map && res.body['message'] != null) {
          return Result(
              isOk: false,
              message: res.body['message']
          );
        } else {
          return Result(
              isOk: false,
              message: language.unknownError
          );
        }
        break;
    }
  }

  void notify() {
    notifyListeners();
  }


}
