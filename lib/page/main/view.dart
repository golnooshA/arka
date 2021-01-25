import 'package:wood/core/router/routes.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wood/core/config/design_config.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset('assets/menu.png'),
          onPressed: () {
           scaffoldKey.currentState.openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: <Widget>[
      IconButton(
      padding: EdgeInsets.zero,
        icon: Icon(Icons.search, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, Routes.search);
        },
      )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //each category has border if it is selected
          // borderColor: DesignConfig.titleColor,

          SliverToBoxAdapter(
              child: CategorySlider(onTap: () {}, buttons: [
            ButtonDynamic(
                text: "Oak",
                textColor: DesignConfig.titleColor,
                buttonColor: DesignConfig.primaryBackgroundColor,
                onTap: () {}),
            ButtonDynamic(
                text: "Pine",
                textColor: DesignConfig.titleColor,
                buttonColor: DesignConfig.primaryBackgroundColor,
                onTap: () {}),
            ButtonDynamic(
                text: "Veneered MDF Sheeting",
                textColor: DesignConfig.titleColor,
                buttonColor: DesignConfig.primaryBackgroundColor,
                onTap: () {}),
            ButtonDynamic(
                text: "Ash",
                textColor: DesignConfig.titleColor,
                buttonColor: DesignConfig.primaryBackgroundColor,
                onTap: () {}),
            ButtonDynamic(
                text: "Oeche",
                textColor: DesignConfig.titleColor,
                buttonColor: DesignConfig.primaryBackgroundColor,
                onTap: () {}),
          ])),

          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/sale.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Best',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: DesignConfig.bigFontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Sale',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: DesignConfig.bigFontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  ButtonText(
                      textColor: Colors.white,
                      minWidth: 70,
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      text: 'see more',
                      fontSize: DesignConfig.mediumFontSize,
                      buttonColor: Colors.transparent,
                      borderColor: Colors.white,
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.discount);
                      })
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 12),
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

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              itemCount: 10,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9,
              staggeredTileBuilder: (int index) {
                return new StaggeredTile.count(1, index.isEven ? 2 : 1);
              },
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.oneProduct);
                    },
                    iconOnTap: () {},
                    icon: Icons.favorite_border,
                    price: '120000000000 IRR',
                    // discount: '545464646',
                    // timer: "09:09:06",
                    image:
                        'https://www.azingar.ir/wp-content/uploads/2019/12/Walnut-Wood-Seamless-Background-Texture-6.jpg');
              },
            ),
          )
        ],
      ),
    );
  }
}
