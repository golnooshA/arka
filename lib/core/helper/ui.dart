import 'package:flutter/material.dart' as m;
import 'package:wood/core/config/design_config.dart';
import 'package:wood/core/router/routes.dart';

m.ScaffoldFeatureController<m.SnackBar, m.SnackBarClosedReason> showSnackBar({m.BuildContext context, m.Color backgroundColor = DesignConfig.errorColor, String text}){
  return m.ScaffoldMessenger.of(context).showSnackBar(m.SnackBar(
    backgroundColor: backgroundColor,
    content: m.Row(
      mainAxisAlignment: m.MainAxisAlignment.center,
      children: [
        m.Text(text),
      ],
    ),
  ));
}

Future<T> showDialog<T>({
  m.BuildContext context,
  String text,
  Function onCancel,
  Function onOk,
  String okText,
  String cancelText
}) {
  return m.showDialog(
      context: context,
      builder: (_) => m.Dialog(
        shape: m.RoundedRectangleBorder(
          borderRadius: m.BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        backgroundColor: m.Colors.white,
        insetPadding: m.EdgeInsets.all(20.0),
        child: m.Column(
          mainAxisSize: m.MainAxisSize.min,
          children: [
            m.Text(
              text,
              textAlign: m.TextAlign.center,
              style: m.TextStyle(
                fontSize: DesignConfig.titleFontSize,
                color: DesignConfig.errorColor,
              ),
            ),
            m.SizedBox(height: 20.0),
            m.Row(
              mainAxisAlignment: m.MainAxisAlignment.spaceEvenly,
              children: [
                if(onOk != null) m.MaterialButton(
                  onPressed: onOk,
                  color: DesignConfig.primaryColor,
                  child: m.Text(
                    okText,
                    style: m.TextStyle(
                        fontSize: DesignConfig.titleFontSize,
                        color: m.Colors.white),
                  ),
                ),
                if(onCancel != null) m.MaterialButton(
                  onPressed: onCancel,
                  child: m.Text(
                    cancelText,
                    style: m.TextStyle(
                        fontSize: DesignConfig.titleFontSize,
                        color: DesignConfig.titleColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
  );
}