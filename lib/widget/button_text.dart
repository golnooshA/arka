import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../core/config/design_config.dart';
import '../core/config/design_config.dart';
import '../core/config/design_config.dart';

class ButtonText extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color textColor;
  final Color borderColor;
  final double minWidth;
  final double height;
  final double fontSize;
  final Color buttonColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  ButtonText(
      {@required this.onTap,
      @required this.textColor,
      @required this.minWidth,
      @required this.text,
      @required this.buttonColor,
      this.height,
      this.borderColor = Colors.transparent,
      this.fontSize = 12,
      EdgeInsetsGeometry padding,
      EdgeInsetsGeometry margin
      })
      :
        this.padding= padding ?? EdgeInsets.all(20),
        this.margin= margin ?? EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
        minWidth: minWidth,
        height: height,
        color: buttonColor,
        elevation: 0,
        splashColor: DesignConfig.splashColor,
        highlightColor: DesignConfig.highlightColor,
        padding: padding,
        shape: RoundedRectangleBorder(side: BorderSide(color: borderColor)),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600)),
        onPressed: onTap,
      ),
    );
  }
}
