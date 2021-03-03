import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/data/product.dart';
import 'package:wood/page/cart/state.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/linear_progress.dart';
import '../../core/config/design_config.dart';
import 'package:wood/core/helper/ui.dart' as ui;

class OneProduct extends StatefulWidget {
  final Product oneProduct;

  OneProduct({this.oneProduct});

  @override
  _OneProductState createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  CartController cartController;
  Settings settings;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  void didChangeDependencies() {

    if(settings == null){
      settings = Provider.of<Settings>(context, listen: false);
    }
    if(cartController == null){
      cartController = Provider.of<CartController>(context, listen: false);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final s = Scaffold(
      key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: DesignConfig.bookmarkColor),
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
                padding: EdgeInsets.zero,
                splashColor: DesignConfig.splashColor,
                highlightColor: DesignConfig.highlightColor),
            // IconButton(
            //     icon: Icon(Icons.favorite_border),
            //     onPressed: () {},
            //     padding: EdgeInsets.zero,
            //     splashColor: DesignConfig.splashColor,
            //     highlightColor: DesignConfig.highlightColor),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.oneProduct.name,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                                color: DesignConfig.bookmarkColor,
                                fontSize: DesignConfig.appBarTextFontSize,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            color: DesignConfig.priceCardColor,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(top: 20, bottom: 8),
                            child: Text(
                              Product.formattedNumber(
                                  widget.oneProduct.offerPrice == null
                                      ? widget.oneProduct.price
                                      : widget.oneProduct.offerPrice,
                                  suffix: ' IRR'),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                  color: DesignConfig.bookmarkColor,
                                  fontSize: DesignConfig.titleFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (widget.oneProduct.offerPrice != null)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 20),
                              child: Text(
                                Product.formattedNumber(widget.oneProduct.price,
                                    suffix: ' IRR'),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: TextStyle(
                                    color: DesignConfig.priceColor,
                                    fontSize: DesignConfig.mediumFontSize,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                        icon: Icon(Icons.shopping_cart,
                                            color: DesignConfig.bookmarkColor,
                                            size: 30),
                                        onPressed: () {

                                          print("******Clicking on button******");

                                          if(!settings.isSoftLogin()){

                                            print("******!settings.isSoftLogin()******");
                                            ui.showSnackBar(
                                                context: context,
                                                text: 'should login',
                                              backgroundColor: Colors.orange
                                            );
                                            return;
                                          }
                                          final count = cartController.storageCart[widget.oneProduct.id]?.count;
                                          if(count != null && widget.oneProduct.number <= count){
                                            print("******count != null && widget.oneProduct.number <= count******");

                                            ui.showSnackBar(
                                                context: context,
                                                text: 'finish'
                                            );
                                            return;
                                          }
                                          if(widget.oneProduct.number < 1){
                                            print("******widget.oneProduct.number < 1******");

                                            ui.showSnackBar(
                                                context: context,
                                                text: 'finish'
                                            );
                                            return;
                                          }
                                          cartController.setToCart(widget.oneProduct.withCount(count: count == null ? 1 : count + 1), notify: true);

                                        },
                                        padding: EdgeInsets.zero,
                                        splashColor: DesignConfig.splashColor,
                                        highlightColor:
                                            DesignConfig.highlightColor),
                                  ),

                                  //It is cart products number
                                  Consumer<CartController>(
                                    builder: (_, cartController, child) {
                                      return cartController.storageCart[widget.oneProduct.id]
                                          ?.count == null ? Container() : Container(
                                        width: 24,
                                        height: 24,
                                        padding: EdgeInsets.all(4),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: DesignConfig.cartNumberColor,
                                            shape: BoxShape.circle),
                                        child: Text(cartController.storageCart[widget.oneProduct
                                            .id]?.count.toString(),

                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: DesignConfig.titleColor,
                                              fontSize: DesignConfig.tinyFontSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                    icon: Icon(Icons.photo,
                                        color: DesignConfig.bookmarkColor,
                                        size: 30),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.gallery,
                                          arguments: widget.oneProduct.id);
                                    },
                                    padding: EdgeInsets.zero,
                                    splashColor: DesignConfig.splashColor,
                                    highlightColor:
                                        DesignConfig.highlightColor),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, bottom: 4),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'more info',
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: DesignConfig.bookmarkColor,
                                        fontSize: DesignConfig.textFontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                InkWrapper(
                                  borderRadius: DesignConfig.infoBorderRadius,
                                  highlightColor: DesignConfig.highlightColor,
                                  splashColor: DesignConfig.splashColor,
                                  child: Icon(Icons.keyboard_arrow_down,
                                      color: DesignConfig.bookmarkColor,
                                      size: 30),
                                  onTap: () async {
                                    await showModalBottomSheet<String>(
                                        context: context,
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        builder: (BuildContext buildContext) {
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    top: 12),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: DesignConfig
                                                            .appBarOptionsColor,
                                                        size: 40),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    splashColor: DesignConfig
                                                        .splashColor,
                                                    highlightColor: DesignConfig
                                                        .highlightColor),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Thickness',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: DesignConfig
                                                          .titleColor,
                                                      fontSize: DesignConfig
                                                          .mediumFontSize,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 12),
                                                  child: Text(
                                                    widget.oneProduct.thickness,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: DesignConfig
                                                            .titleColor,
                                                        fontSize: DesignConfig
                                                            .subtitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Size (mm)',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: DesignConfig
                                                          .titleColor,
                                                      fontSize: DesignConfig
                                                          .mediumFontSize,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 12),
                                                  child: Text(
                                                    widget.oneProduct.size,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: DesignConfig
                                                            .titleColor,
                                                        fontSize: DesignConfig
                                                            .subtitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Weight / Piece (kg)',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: DesignConfig
                                                          .titleColor,
                                                      fontSize: DesignConfig
                                                          .mediumFontSize,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 12),
                                                  child: Text(
                                                    widget.oneProduct.weight,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: DesignConfig
                                                            .titleColor,
                                                        fontSize: DesignConfig
                                                            .subtitleFontSize,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Number',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: DesignConfig
                                                          .titleColor,
                                                      fontSize: DesignConfig
                                                          .mediumFontSize,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8, bottom: 12),
                                                  child: LinearProgress(
                                                      fillColor: widget.oneProduct.stock == null ||
                                                              widget.oneProduct.stock ==
                                                                  0
                                                          ? DesignConfig
                                                              .emptyProductColor
                                                          : (widget.oneProduct.stock < 51
                                                              ? DesignConfig
                                                                  .halfFullProductColor
                                                              : DesignConfig
                                                                  .fullProductColor),
                                                      progress: widget.oneProduct
                                                                      .stock ==
                                                                  null ||
                                                              widget.oneProduct
                                                                      .stock ==
                                                                  0
                                                          ? 0.001
                                                          : widget.oneProduct.stock /
                                                              100,
                                                      backgroundColor: DesignConfig
                                                          .halfFullProductColor),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));

    return CachedNetworkImage(
      imageUrl: widget.oneProduct.image,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      imageBuilder: (_, provider) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        )),
        child: s,
      ),
      errorWidget: (_, __, ___) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/placeholder.jpg'),
          fit: BoxFit.cover,
        )),
        child: s,
      ),
      placeholder: (_, __) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/placeholder.jpg'),
          fit: BoxFit.cover,
        )),
        child: s,
      ),
    );
  }
}
