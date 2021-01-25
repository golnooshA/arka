import 'package:wood/core/config/design_config.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/widget/link_button.dart';
import 'package:flutter/material.dart';

class PageNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('404', style: TextStyle(fontSize: 80, color: DesignConfig.titleColor), textAlign: TextAlign.center,),
            Text('صفحه مورد نظر یافت نشد', textAlign: TextAlign.center,),
            Padding(
              padding: EdgeInsets.all(20),
              child: LinkButton(
                  text: 'بازگشت به صفحه اصلی',
                  onTap: (){
                    //Navigator.pushReplacementNamed(context, Routes.main);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
