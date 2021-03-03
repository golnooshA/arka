import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/main/scroll_state.dart';
import 'package:wood/page/search/state.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/form.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/loading.dart';
import '../../core/config/design_config.dart';

class Search extends StatefulWidget {

  final ScrollPageState scrollState;


  const Search({this.scrollState});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocusNode = FocusNode();
  bool focusRequested = false;

  ScrollController scrollController;
  int page = 1;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SearchStateController _stateController;

  scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      final _stateController = Provider.of<SearchStateController>(context, listen: false);
      if (_stateController.status == Status.ready) {
        page++;
        await _stateController.getProduct(searchText:'',refresh: true);

      }
    }
    widget.scrollState.setScroll(scrollController.position.pixels);
  }

  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    _stateController = Provider.of<SearchStateController>(context, listen: false);
    _stateController.getProduct(searchText:'', refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!focusRequested){
      searchFocusNode.requestFocus();
      focusRequested = true;
    }

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
      body: Column(
        children: [

          TextFieldSimple(
            title: "Search",
            icon: Icons.search,
            controller: searchController,
            margin: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 0),
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


          Expanded(child: Consumer<SearchStateController>(
            builder: (_, _stateController, child){
              switch (_stateController.status) {
                case Status.ready:
                  return CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index){
                              final item = _stateController.products[index];
                              print("*********item**********$item");
                              return InkWrapper(
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, Routes.oneProduct, arguments: item);

                                },
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
                                        url: item.image,
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
                                              item.name,
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
                                              Product.formattedNumber(item.price, suffix: ' IRR'),
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
                            childCount: _stateController.products.length
                        ),
                      )
                    ],
                  );

                case Status.loading:
                  return Loading();
                  break;

                case Status.empty:
                  return Loading();
                  break;

                default:
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      child,
                      Error(
                          message: _stateController.errorMessage,
                          buttonText: "try again",
                          onButtonTap: () {
                            _stateController.getProduct(searchText:'',refresh: true);
                          }) ],
                  );
              }
            },
          ))
        ],
      ),
    );
  }

  void onSearch(String val){
    if(val == null || val.trim() == ''){
      print("*********val**********$val");

      val = '';
    }
    searchFocusNode.unfocus();
    _stateController.getProduct(searchText: val);
  }
}
