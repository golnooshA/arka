import 'package:wood/core/router/routes.dart';
import 'package:wood/data/args.dart';
import 'package:wood/page/main/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/form.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
        title: Text('Search',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: CustomScrollView(
        slivers: [

          // use in Consumer child
          SliverToBoxAdapter(
            child: TextFieldSimple(
              title: "Search",
              icon: Icons.search,
              controller: searchController,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              maxLines: 1,
              keyboardType: TextInputType.text,
              keyboardButtonAction: TextInputAction.search,
              focusNode: searchFocusNode,
              onFieldSubmitted: onSearch,
            ),
          ),

          //use as a search card
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index){
                  return InkWrapper(
                    onTap: (){},
                    highlightColor: DesignConfig.highlightColor,
                    splashColor: DesignConfig.splashColor,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          DefaultNetworkImage(
                            url: 'https://www.azingar.ir/wp-content/uploads/2019/12/Walnut-Wood-Seamless-Background-Texture-6.jpg',
                            fit: BoxFit.cover,
                            margin: EdgeInsets.zero,
                            height: double.infinity,
                            width: 50,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8,right: 8, bottom: 4),
                                child: Text(
                                  "Product Name",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: DesignConfig.textColor,
                                      fontSize: DesignConfig.textFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8,right: 8, top: 4),
                                child: Text(
                                  "Product Price",
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: DesignConfig.textColor,
                                      fontSize: DesignConfig.mediumFontSize,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: 10
            ),
          )
        ],
      ),
    );
  }
  void onSearch(String val){
    if(val != null && val.trim() != ''){
      searchFocusNode.unfocus();
      Navigator.pushNamed(context, Routes.search, arguments: Args(
          title: 'Search: ' + val,
          text: val
      ));
    }
  }
}
