import 'package:flutter/material.dart';
import 'package:wood/widget/link_button.dart';

class Error extends StatelessWidget {
  final String message;
  final String buttonText;
  final Function onButtonTap;
  final EdgeInsetsGeometry margin;

  Error(
      {@required this.message,
      @required this.buttonText,
      @required this.onButtonTap,
        this.margin
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(message)),
          if(onButtonTap != null) FractionallySizedBox(
            widthFactor: .4,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: LinkButton(text: "$buttonText", onTap: onButtonTap),
            ),
          )
        ],
      ),
    );
  }
}
