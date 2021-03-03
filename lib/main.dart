import 'package:wood/core/localization/app_localizations_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wood/page/blog/state.dart';
import 'package:wood/page/bookmark/state.dart';
import 'package:wood/page/cart/state.dart';
import 'package:wood/page/discount/state.dart';
import 'package:wood/page/gallery/state.dart';
import 'package:wood/page/main/state.dart';
import 'package:wood/page/search/state.dart';
import 'core/config/design_config.dart';
import 'core/router/routes.dart';
import 'core/storage/settings.dart';
import 'page/main/scroll_state.dart';
import 'page/one_blog/state.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Settings>(
        create: (_) => Settings()..init(),
      ),

      ChangeNotifierProvider<MainController>(
        create: (context) => MainController(),
      ),
      ChangeNotifierProvider<ScrollPageState>(
        create: (context) => ScrollPageState(),
      ),

      ChangeNotifierProvider<BookmarkController>(
        create: (context) => BookmarkController(),
      ),

      ChangeNotifierProvider<SearchStateController>(
        create: (context) => SearchStateController(),
      ),

      ChangeNotifierProvider<DiscountController>(
        create: (context) => DiscountController(),
      ),

      ChangeNotifierProvider<BlogController>(
        create: (context) => BlogController(),
      ),

      ChangeNotifierProvider<OneBlogController>(
        create: (context) => OneBlogController(),
      ),

      ChangeNotifierProvider<CartController>(
        create: (context) => CartController(),
      ),



    ],
    child: Consumer<Settings>(
      builder: (context, settings, __) {
        if (!settings.isInit) {
          return Container();
          return Material(
              child: Image.asset("assets/splash.jpg", width: 400, height: 400, fit: BoxFit.cover));
        }
        return MaterialApp(
          initialRoute: Routes.home,
          onGenerateRoute: Routes.onGenerateRoutes,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            const Locale('en'),
            const Locale('fa'),
          ],

          locale: settings.locale,
          theme: ThemeData(
            backgroundColor: DesignConfig.backgroundColor,
            splashColor: DesignConfig.backgroundColor,
            primaryColor: DesignConfig.appColor,
            accentColor: DesignConfig.backgroundColor,
            fontFamily: settings.fontFamily,
          ),
        );
      },
    ),
  ));
}