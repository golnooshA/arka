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

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        title: Text('About Us',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: Image.asset('assets/logo.png',
                      fit: BoxFit.cover, width: 100, height: 100))),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '''Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.''',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: DesignConfig.titleColor,
                    fontSize: DesignConfig.textFontSize,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  height: 85,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      DefaultNetworkImage(
                        url:
                            'https://cdn.zoomg.ir/2018/7/ad82d705-2e7b-4d26-a77d-526fa4b8c1b0.jpg?w=768',
                        fit: BoxFit.cover,
                        margin: EdgeInsets.zero,
                        height: double.infinity,
                        width: 85,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Text(
                              "Matt Micucci",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: DesignConfig.titleColor,
                                  fontSize: DesignConfig.textFontSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 4),
                            child: Text(
                              "Manager",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: DesignConfig.textColor,
                                  fontSize: DesignConfig.textFontSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }, childCount: 10),
            ),
          )
        ],
      ),
    );
  }
}
