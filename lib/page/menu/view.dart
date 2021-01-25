import 'package:wood/core/config/design_config.dart';
import 'package:wood/core/router/routes.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100), topRight: Radius.circular(100))
      ),
      child: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          splashColor: DesignConfig.splashColor,
                          highlightColor: DesignConfig.highlightColor,
                          icon: Icon(Icons.language,
                              size: 30,
                              color: DesignConfig.appBarOptionsColor),
                          onPressed: () {}),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          //language button
                          IconButton(
                              splashColor: DesignConfig.splashColor,
                              highlightColor: DesignConfig.highlightColor,
                              icon: Icon(Icons.shopping_cart_outlined,
                                  size: 30,

                                  color: DesignConfig.appBarOptionsColor),
                              onPressed: () {}),

                          //It is cart products number
                          Container(
                            width: 24,
                            height: 24,
                            padding: EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: DesignConfig.cartNumberColor,
                                shape: BoxShape.circle),
                            child: Text(
                              '0',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: DesignConfig.titleColor,
                                  fontSize: DesignConfig.tinyFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ListView(children: [
                  ListTile(
                    title: Text('Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.login);
                    },
                  ),
                  ListTile(
                    title: Text('Products',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.home);
                    },
                  ),
                  ListTile(
                    title: Text('Blog',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.blog);
                    },
                  ),
                  ListTile(
                    title: Text('My Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.cart);
                    },
                  ),
                  ListTile(
                    title: Text('Favorite',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.bookmark);
                    },
                  ),
                  ListTile(
                    title: Text('About Us',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.aboutUs);
                    },
                  ),
                  ListTile(
                    title: Text('Contact Us',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: DesignConfig.textFontSize,
                          color: DesignConfig.titleColor,
                        )),
                    // contentPadding: EdgeInsets.all(4),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.contactUs);
                    },
                  ),
                ]),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text('Arka Chobineh Part',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: DesignConfig.titleColor, fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//Click on language button and new window is opened

// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.only(
// bottomRight: Radius.circular(100), topRight: Radius.circular(100))
// ),
// child: SizedBox(
// width: 200,
// child: Drawer(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Expanded(
// flex: 1,
// child: Container(
// margin: EdgeInsets.only(top: 20, left: 10, right: 10),
// height: double.infinity,
// width: MediaQuery.of(context).size.width,
// alignment: AlignmentDirectional.centerEnd,
// child: IconButton(
// splashColor: DesignConfig.splashColor,
// highlightColor: DesignConfig.highlightColor,
// icon: Icon(Icons.close,
// size: 30,
// color: DesignConfig.appBarOptionsColor),
// onPressed: () {}),
// ),
// ),
// Expanded(
// flex: 8,
// child: ListView(children: [
// ListTile(
// title: Text('English',
// style: TextStyle(
// fontWeight: FontWeight.w400,
// fontSize: DesignConfig.textFontSize,
// color: DesignConfig.titleColor,
// )),
// // contentPadding: EdgeInsets.all(4),
// onTap: () {},
// ),
// ListTile(
// title: Text('Persian',
// style: TextStyle(
// fontWeight: FontWeight.w400,
// fontSize: DesignConfig.textFontSize,
// color: DesignConfig.titleColor,
// )),
// // contentPadding: EdgeInsets.all(4),
// onTap: () {},
// ),
// ]),
// ),
// ],
// ),
// ),
// ),
// )