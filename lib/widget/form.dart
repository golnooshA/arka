import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../core/config/design_config.dart';

class TextFieldSimple extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction keyboardButtonAction;
  final void Function(String) onFieldSubmitted;
  final double width;
  final EdgeInsetsGeometry margin;
  final int maxLines;
  final IconData icon;

  TextFieldSimple(
      {Key key,
      @required this.title,
      @required this.controller,
      this.width,
      EdgeInsetsGeometry margin,
      BorderRadius borderRadius,
      this.maxLines = 1,
      this.keyboardButtonAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.onFieldSubmitted,
      this.icon})
      : this.margin = margin ?? EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 4),
      margin: margin,
      child: TextFormField(
        style: TextStyle(
            color: DesignConfig.textFieldColor,
            fontSize: DesignConfig.textFontSize),
        controller: controller,
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        focusNode: focusNode,
        textInputAction: keyboardButtonAction,
        decoration: InputDecoration(
          prefixIcon: (icon != null) ? Icon(
            icon,
            color: DesignConfig.textFieldColor,
          ) : null,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          hintMaxLines: maxLines,
          hintText: title,
          hintStyle: TextStyle(
              color: DesignConfig.textFieldColor,
              fontSize: DesignConfig.textFontSize,
          fontWeight: FontWeight.w600),
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.transparent,
        ),
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
