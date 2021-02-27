import 'package:wood/data/article.dart';
import 'package:wood/data/product.dart';
import 'package:wood/page/about_us/view.dart';
import 'package:wood/page/blog/view.dart';
import 'package:wood/page/bookmark/view.dart';
import 'package:wood/page/category/view.dart';
import 'package:wood/page/contact_us/view.dart';
import 'package:wood/page/discount/view.dart';
import 'package:wood/page/edit_profile/view.dart';
import 'package:wood/page/gallery/state.dart';
import 'package:wood/page/gallery/view.dart';
import 'package:wood/page/login/view.dart';
import 'package:wood/page/main/state.dart';
import 'package:wood/page/main/view.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/page/one_blog/state.dart';
import 'package:wood/page/one_blog/view.dart';
import 'package:wood/page/one_product/view.dart';
import 'package:wood/page/page_not_found/view.dart';
import 'package:wood/page/search/view.dart';
import 'package:wood/page/cart/view.dart';
import 'package:flutter/material.dart';
import 'package:wood/core/router/route_parser.dart';
import 'package:wood/core/router/route_transition.dart';
import 'package:provider/provider.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const search = '/search';
  static const menu = '/menu';
  static const discount = '/discount';
  static const category = '/category';
  static const oneProduct = '/one_product';
  static const gallery = '/gallery';
  static const aboutUs = '/about_us';
  static const contactUs = '/contact_us';
  static const bookmark = '/bookmark';
  static const cart = '/cart';
  static const blog = '/blog';
  static const oneBlog = '/one_blog';
  static const editProfile = '/edit_profile';

  static Route<dynamic> onGenerateRoutes(RouteSettings rawSettings) {

    final parsedRoute = RouteParser.parse(rawSettings.name);
    final settings = RouteSettings(
        name: parsedRoute.name + (rawSettings.arguments is int ? '/${rawSettings.arguments}' : (parsedRoute.arg == null ? '' : '/${parsedRoute.arg}')),
        arguments: parsedRoute.arg ?? rawSettings.arguments
    );

    print('name: ${parsedRoute.name}');
    print('name: ${parsedRoute.arg}');

    Widget page;
    switch (parsedRoute.name) {

      case Routes.login:
        page = Login();
        break;

      case Routes.home:
        page = Main();
        break;

      case Routes.search:
        page = Search();
        break;

      case Routes.menu:
        page = Menu();
        break;

      case Routes.discount:
        page = Discount();
        break;

      case Routes.category:
        page = Category();
        break;

      case Routes.oneProduct:
        if(settings.arguments is! Product){
          page = PageNotFoundPage();
          break;
        }
        page = ChangeNotifierProvider<MainController>(
          create: (_) => MainController(),
          child: OneProduct(oneProduct: settings.arguments),
        );
        break;

      case Routes.gallery:
        if(settings.arguments is! int){
          page = PageNotFoundPage();
          break;
        }
        page = ChangeNotifierProvider<GalleryController>(
          create: (_) => GalleryController(),
          child: Gallery(id: settings.arguments),
        );
        break;


      case Routes.aboutUs:
        page = AboutUs();
        break;

      case Routes.contactUs:
        page = ContactUs();
        break;

      case Routes.bookmark:
        page = Bookmark();
        break;

      case Routes.cart:
        page = Cart();
        break;

      case Routes.editProfile:
        page = EditProfile();
        break;

      case Routes.blog:
        page = Blog();
        break;

      case Routes.oneBlog:
        if(settings.arguments is! Article){
          page = PageNotFoundPage();
          break;
        }
        page = ChangeNotifierProvider<OneBlogController>(
          create: (_) => OneBlogController(),
          child: OneBlog(article: settings.arguments),
        );
        break;


      default:
        page = PageNotFoundPage();

    }
    return PageRouteBuilder(
        pageBuilder: (context, __, ___) => page,
        transitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
          final mediaQuery = MediaQuery.of(context);
          return DefaultRouteTransition(
              child: MediaQuery(
                data: mediaQuery.copyWith(
                  textScaleFactor: mediaQuery.devicePixelRatio > 2 ? mediaQuery.textScaleFactor : 0.85
                ),
                child: page,
              ),
              animation: animation,
              secondaryAnimation: secondaryAnimation,
            );
        });
  }
}
