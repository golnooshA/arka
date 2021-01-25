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

class OneBlog extends StatefulWidget {
  @override
  _OneBlogState createState() => _OneBlogState();
}

class _OneBlogState extends State<OneBlog> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
          elevation: 0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: DefaultNetworkImage(
              url:
                  'https://shop98ia.ir/upload/2019/12/06/c5fac9159f002d0-6ba7d6869f3-07b0c467832.jpg',
              fit: BoxFit.cover,
              margin: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Patio Conversation Sets Can Make Your Outdoor Space More User-Friendly',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: DesignConfig.titleColor,
                    fontSize: DesignConfig.appBarTextFontSize,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
          )
        ],
      ),
    );
  }
}
