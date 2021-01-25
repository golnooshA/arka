import 'package:wood/core/router/routes.dart';
import 'package:wood/data/args.dart';
import 'package:wood/page/main/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/form.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text('Gallery',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.only(left: 20,right: 20,top: 40),
            sliver:  SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              itemCount: 10,
              mainAxisSpacing: 9,
              crossAxisSpacing:9,
              staggeredTileBuilder: (int index) {
                return new StaggeredTile.count(1,1);
              },
              itemBuilder: (BuildContext context, int index) {
                return  InkWrapper(
                  onTap: (){},
                  highlightColor: DesignConfig.highlightColor,
                  splashColor: DesignConfig.splashColor,
                  child: DefaultNetworkImage(
                    url:
                    'https://www.azingar.ir/wp-content/uploads/2019/12/Walnut-Wood-Seamless-Background-Texture-6.jpg',
                    fit: BoxFit.cover,
                    margin: EdgeInsets.zero,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            ),)
        ],
      ),
    );
  }
}
