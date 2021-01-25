import 'package:flutter/material.dart';
import '../core/config/design_config.dart';

class CategorySlider extends StatelessWidget {

  final Function onTap;
  final List<ButtonDynamic> buttons;

  CategorySlider({
    @required this.onTap,
    @required this.buttons
  }) ;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 80,
      child: ListView.builder(
          itemCount: buttons.length,
          shrinkWrap: true,
          reverse: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => buttons[index]
      ),
    );
  }
}


class ButtonDynamic extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color textColor;
  final Color borderColor;
  final Color buttonColor;
  final EdgeInsetsGeometry margin;


  ButtonDynamic(
      {this.onTap,
        @required this.textColor,
        @required this.text,
        @required this.buttonColor,
        this.borderColor = Colors.transparent,
        EdgeInsetsGeometry margin})
      :
        this.margin = margin ?? EdgeInsets.symmetric(horizontal: 8, vertical: 20);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RawMaterialButton(
        splashColor: DesignConfig.splashColor,
        highlightColor: DesignConfig.highlightColor,
        onPressed: onTap,
        child: Text(
          text,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DesignConfig.titleColor,
            fontSize: DesignConfig.mediumFontSize,
            fontWeight: FontWeight.w400
          ),
        ),
        // shape: RoundedRectangleBorder(
        //     side:BorderSide(
        //         color: DesignConfig.titleColor
        //     )
        // ),
        elevation: 0,
        fillColor: DesignConfig.primaryBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }
}



