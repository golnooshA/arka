import 'package:wood/core/router/routes.dart';
import 'package:wood/page/main/view.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
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
        title: Text('Blog',
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 12),
              child: Text(
                'Showing 80 blogs',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.mediumFontSize,
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index){
                  return  InkWrapper(
                    onTap: (){
                      Navigator.pushNamed(
                          context, Routes.oneBlog);
                    },
                    highlightColor: DesignConfig.highlightColor,
                    splashColor: DesignConfig.splashColor,

                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex:5,
                            child: DefaultNetworkImage(
                              url: 'https://shop98ia.ir/upload/2019/12/06/c5fac9159f002d0-6ba7d6869f3-07b0c467832.jpg',
                              fit: BoxFit.cover,
                              margin: EdgeInsets.zero,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "50 Ways to Leave Your Old Home Decor ",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: DesignConfig.titleColor,
                                  fontSize: DesignConfig.textFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          Container(
                            child: Text(
                              "Ilutions, but we can also come up ",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: DesignConfig.textColor,
                                  fontSize: DesignConfig.mediumFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 5
            ),
          ),


        ],
      ),
    );
  }
}
