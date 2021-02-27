import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wood/core/config/design_config.dart';
import 'package:wood/widget/ink_wrapper.dart';

class ActionSheetSimple extends StatelessWidget {

  final List<ActionSheeSimpleData> data;
  final Widget child;

  const ActionSheetSimple({

    this.data,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return
      DraggableScrollableSheet(
        initialChildSize: 0.5, // half screen on load
        maxChildSize: 1,       // full screen on scroll
        minChildSize: 0.25,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            width: double.infinity,
            color: Colors.white,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWrapper(
                    highlightColor: DesignConfig.highlightColor,
                    splashColor: DesignConfig.splashColor,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        data[index].title,
                        style: TextStyle(
                            fontSize: 12,
                            color: DesignConfig.textColor
                        ),
                      ),

                    ),
                    onTap: data[index].onTap,
                  );
                },
              ),
            ),
          );
        },
      );
  }
}

class ActionSheeSimpleData {
  final String title;
  final Function onTap;

  ActionSheeSimpleData({
    @required this.title,
    @required this.onTap
  }) :
        assert(title != null),
        assert(onTap != null);
}
