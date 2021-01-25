import 'package:flutter/material.dart';
import 'package:wood/core/config/design_config.dart';
import 'package:wood/widget/ink_wrapper.dart';

class LinkButton extends StatelessWidget {

  final String text;
  final Function onTap;

  LinkButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWrapper(
      onTap: onTap,
      highlightColor: DesignConfig.highlightColor,
      splashColor: DesignConfig.splashColor,
      // borderRadius: DesignConfig.primaryBorderRadius,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          // borderRadius: DesignConfig.primaryBorderRadius
        ),
        child: Text(text, style: TextStyle(
          color: DesignConfig.textColor,
          fontSize: DesignConfig.buttonFontSize,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
