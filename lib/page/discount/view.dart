import 'package:wood/core/router/routes.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class Discount extends StatefulWidget {
  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
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
        title: Text('Discount',
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 12),
              child: Text(
                'Showing 80 products',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.mediumFontSize,
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.symmetric(horizontal: 20),
            sliver:  SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              itemCount: 10,
              mainAxisSpacing: 9,
              crossAxisSpacing:9,
              staggeredTileBuilder: (int index) {
                return new StaggeredTile.count(1,1);
              },
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                    onTap: (){
                      Navigator.pushNamed(
                          context, Routes.oneProduct);
                    },
                    iconOnTap: (){},
                    icon: Icons.favorite_border,
                    price: '120000000000 IRR',
                    discount: '14000000000000',
                    timer: "09:09:06",
                    image: 'https://www.azingar.ir/wp-content/uploads/2019/12/Walnut-Wood-Seamless-Background-Texture-6.jpg');
              },
            ),)
        ],
      ),
    );
  }
}
