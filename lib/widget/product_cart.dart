import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../core/config/design_config.dart';
import 'default_network_image.dart';

class ProductCard extends StatelessWidget {
  final Function onTap;
  final Function iconOnTap;
  final Widget timer;
  final String price;
  final String discount;
  final IconData icon;
  final String image;
  final double width;
  final double height;

  ProductCard(
      {@required this.onTap,
      @required this.iconOnTap,
      @required this.icon,
      @required this.price,
      @required this.image,
      this.discount,
      this.timer,
      this.width = double.infinity,
      this.height = double.infinity
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWrapper(
          onTap: onTap,
          highlightColor: DesignConfig.highlightColor,
          splashColor: DesignConfig.splashColor,
          child: DefaultNetworkImage(
            url: image,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
        Container(

          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (timer!= null)? Padding(
                      padding: EdgeInsets.all(12),
                      child: timer,
                      // child: Text(
                      //   timer,
                      //   textDirection: TextDirection.ltr,
                      //   textAlign: TextAlign.start,
                      //   style: TextStyle(
                      //       color: DesignConfig.bookmarkColor,
                      //       fontSize: DesignConfig.mediumFontSize,
                      //       fontWeight: FontWeight.w400),
                      // ),
                    ) : Container(),
                    IconButton(
                        icon: Icon(icon, color: DesignConfig.bookmarkColor),
                        onPressed: iconOnTap,
                        padding: EdgeInsets.zero,
                        splashColor: DesignConfig.splashColor,
                        highlightColor: DesignConfig.highlightColor),

                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: DesignConfig.priceCardColor,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        price,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: DesignConfig.priceColor,
                            fontSize: DesignConfig.mediumFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    (discount != null)? Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        discount,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: DesignConfig.priceColor,
                            fontSize: DesignConfig.mediumFontSize,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ) : Container(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
