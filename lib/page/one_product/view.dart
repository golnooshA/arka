import 'package:wood/core/router/routes.dart';
import 'package:wood/data/product.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/linear_progress.dart';
import '../../core/config/design_config.dart';

class OneProduct extends StatefulWidget {
  final Product oneProduct;

  OneProduct({this.oneProduct});

  @override
  _OneProductState createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  @override
  Widget build(BuildContext context) {
    final s = Scaffold(
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
            IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
                padding: EdgeInsets.zero,
                splashColor: DesignConfig.splashColor,
                highlightColor: DesignConfig.highlightColor),
          ],
        ),
        body: Container(
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
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        Product.formattedNumber(widget.oneProduct.price,
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
                        margin: EdgeInsets.symmetric(horizontal: 8),
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
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                              icon: Icon(Icons.add_shopping_cart_outlined,
                                  color: DesignConfig.bookmarkColor, size: 30),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              splashColor: DesignConfig.splashColor,
                              highlightColor: DesignConfig.highlightColor),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                              icon: Icon(Icons.photo_library_outlined,
                                  color: DesignConfig.bookmarkColor, size: 30),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.gallery);
                              },
                              padding: EdgeInsets.zero,
                              splashColor: DesignConfig.splashColor,
                              highlightColor: DesignConfig.highlightColor),
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
                            child: Icon(Icons.keyboard_arrow_down_outlined,
                                color: DesignConfig.bookmarkColor, size: 30),
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
                                              left: 12, right: 12, top: 12),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: IconButton(
                                              icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: DesignConfig
                                                      .appBarOptionsColor,
                                                  size: 40),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              padding: EdgeInsets.zero,
                                              splashColor:
                                                  DesignConfig.splashColor,
                                              highlightColor:
                                                  DesignConfig.highlightColor),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Thickness',
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: DesignConfig.titleColor,
                                                fontSize:
                                                    DesignConfig.mediumFontSize,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 12),
                                            child: Text(
                                              widget.oneProduct.thickness,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color:
                                                      DesignConfig.titleColor,
                                                  fontSize: DesignConfig
                                                      .subtitleFontSize,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Size (mm)',
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: DesignConfig.titleColor,
                                                fontSize:
                                                    DesignConfig.mediumFontSize,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 12),
                                            child: Text(
                                              widget.oneProduct.size,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color:
                                                      DesignConfig.titleColor,
                                                  fontSize: DesignConfig
                                                      .subtitleFontSize,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Weight / Piece (kg)',
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: DesignConfig.titleColor,
                                                fontSize:
                                                    DesignConfig.mediumFontSize,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 12),
                                            child: Text(
                                              widget.oneProduct.weight,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color:
                                                      DesignConfig.titleColor,
                                                  fontSize: DesignConfig
                                                      .subtitleFontSize,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          title: Text(
                                            'Number',
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: DesignConfig.titleColor,
                                                fontSize:
                                                    DesignConfig.mediumFontSize,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 12),
                                            child: LinearProgress(
                                                fillColor: widget.oneProduct.stock == null || widget.oneProduct.stock == 0 ?
                                                DesignConfig.emptyProductColor :
                                                (widget.oneProduct.stock < 51 ? DesignConfig.halfFullProductColor
                                                        : DesignConfig.fullProductColor),
                                                progress: widget.oneProduct.stock == null || widget.oneProduct.stock == 0
                                                    ? 0.001
                                                    : widget.oneProduct.stock / 100,
                                                backgroundColor: DesignConfig.halfFullProductColor),
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
