import 'package:wood/core/router/routes.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text('Contact Us',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Address',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: DesignConfig.titleColor,
                            fontSize: DesignConfig.textFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Text(
                      'Iran,Esfahan,IranIran,Esfahan',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: DesignConfig.textColor,
                          fontSize: DesignConfig.textFontSize,
                          fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(Icons.location_on,
                        color: DesignConfig.titleColor, size: 30),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Phone',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: DesignConfig.titleColor,
                            fontSize: DesignConfig.textFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Text(
                      '+981234567890',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: DesignConfig.textColor,
                          fontSize: DesignConfig.textFontSize,
                          fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(Icons.phone,
                        color: DesignConfig.titleColor, size: 30),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Email',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: DesignConfig.titleColor,
                            fontSize: DesignConfig.textFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Text(
                      'abcd@gmail.com',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: DesignConfig.textColor,
                          fontSize: DesignConfig.textFontSize,
                          fontWeight: FontWeight.w400),
                    ),
                    leading: Icon(Icons.email,
                        color: DesignConfig.titleColor, size: 30),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    margin: EdgeInsets.all(20),
                    color: Colors.green,
                    child: Text('Show Map'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
