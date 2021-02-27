import 'package:wood/core/router/routes.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: DesignConfig.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
          elevation: 0,
          centerTitle: true,
          title: Text('Cart',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: DesignConfig.appBarOptionsColor,
                  fontSize: DesignConfig.appBarTextFontSize,
                  fontWeight: FontWeight.w400)),
          actions: <Widget>[
        Stack(
        alignment: Alignment.topRight,
          children: [
            //language button
            IconButton(
                splashColor: DesignConfig.splashColor,
                highlightColor: DesignConfig.highlightColor,
                icon: Icon(Icons.shopping_cart_outlined,
                    size: 30, color: DesignConfig.appBarOptionsColor),
                onPressed: () {
                  Navigator.pushNamed(
                      context, Routes.oneProduct);
                }),

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
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: CustomScrollView(
                slivers: [

                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 8),
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

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index){
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWrapper(
                                    onTap: (){
                                      Navigator.pushNamed(
                                          context, Routes.oneProduct);
                                    },
                                    highlightColor: DesignConfig.highlightColor,
                                    splashColor: DesignConfig.splashColor,
                                    child: DefaultNetworkImage(
                                      url: 'https://www.azingar.ir/wp-content/uploads/2019/12/Walnut-Wood-Seamless-Background-Texture-6.jpg',
                                      fit: BoxFit.cover,
                                      margin: EdgeInsets.zero,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 8,right: 8, bottom: 4),
                                        child: Text(
                                          "Product Name",
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: DesignConfig.textColor,
                                              fontSize: DesignConfig.textFontSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),


                                      Container(
                                          margin: EdgeInsets.only(left: 8,right: 8, bottom: 4),
                                          width: MediaQuery.of(context).size.width/4,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: DesignConfig.appBarOptionsColor)                                            ),
                                                child: IconButton(
                                                  splashColor: DesignConfig.splashColor,
                                                  highlightColor: DesignConfig.highlightColor,
                                                  onPressed: () {},
                                                  icon: new Icon(
                                                    Icons.remove,
                                                    color: DesignConfig.appBarOptionsColor,
                                                    size: 14,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),

                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    '12',
                                                    textDirection: TextDirection.ltr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: DesignConfig.appBarOptionsColor,
                                                        fontSize: DesignConfig.textFontSize,
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: 24,
                                                height: 24,
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: DesignConfig.appBarOptionsColor)                                            ),
                                                child: IconButton(
                                                  splashColor: DesignConfig.splashColor,
                                                  highlightColor: DesignConfig.highlightColor,
                                                  onPressed: () {},
                                                  icon:  Icon(
                                                    Icons.add,
                                                    color: DesignConfig.appBarOptionsColor,
                                                    size: 14,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ),
                                            ],
                                          )
                                      ),


                                      Container(
                                        margin: EdgeInsets.only(left: 8,right: 8, top: 4),
                                        child: Text(
                                          "Product Price",
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
                                )
                              ],
                            ),
                          );
                        },
                        childCount: 5
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Divider(color: DesignConfig.textColor,height: 32),
                  ),

                  SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: DesignConfig.appBarOptionsColor,
                                  fontSize: DesignConfig.mediumFontSize,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              '1200000000 IRR',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: DesignConfig.textFontSize,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ButtonText(
                  onTap: (){},
                  textColor: DesignConfig.priceColor,
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  text: 'Go to checkout',
                  buttonColor: DesignConfig.checkoutColor,
                  fontSize: DesignConfig.buttonFontSize),
            )
          ],
        ));
  }
}
