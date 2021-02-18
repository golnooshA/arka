import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/bookmark/state.dart';
import 'package:wood/page/main/state.dart';
import 'package:wood/page/menu/view.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/loading.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wood/core/config/design_config.dart';
import 'scroll_state.dart';

class Main extends StatefulWidget {
  final ScrollPageState scrollState;
  final int id;

  const Main({this.scrollState, this.id});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController scrollController;
  int page = 1;

  scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      final mainData = Provider.of<MainController>(context, listen: false);
      if (mainData.status == Status.ready) {
        page++;
        await mainData.getProduct(id: widget.id, page: page);
      }
    }
    widget.scrollState.setScroll(scrollController.position.pixels);
  }

  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    final mainData = Provider.of<MainController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      mainData.getData(id: widget.id, refresh: true);
      mainData.getProduct(id: widget.id, page: page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels != widget.scrollState.getScroll()) {
        scrollController.jumpTo(widget.scrollState.getScroll());
      }
    }

    final bookmark = Provider.of<BookmarkController>(context, listen: false);

    return Scaffold(
        backgroundColor: DesignConfig.backgroundColor,
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset('assets/menu.png'),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, Routes.search);
              },
            )
          ],
        ),
        body: Consumer<MainController>(
          builder: (_, mainData, child) {
            switch (mainData.status) {
              case Status.ready:
                return RefreshIndicator(
                    onRefresh: () async {
                      await mainData.getData(id: widget.id, refresh: true);
                      await mainData.getProduct(
                          id: widget.id, page: page, refresh: true);
                    },
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        //each category has border if it is selected
                        // borderColor: DesignConfig.titleColor,

                        if (mainData.categories.isNotEmpty)
                          SliverToBoxAdapter(
                              child: CategorySlider(
                                  onTap: () {},
                                  buttons: mainData.categories
                                      .map(
                                        (e) => ButtonDynamic(
                                            text: e.name,
                                            textColor: DesignConfig.titleColor,
                                            buttonColor: DesignConfig
                                                .primaryBackgroundColor,
                                            onTap: () {}),
                                      )
                                      .toList())),

                        SliverToBoxAdapter(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 1.5,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/sale.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Best',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: DesignConfig.bigFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Sale',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: DesignConfig.bigFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                                ButtonText(
                                    textColor: Colors.white,
                                    minWidth: 70,
                                    height: 30,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    text: 'see more',
                                    fontSize: DesignConfig.mediumFontSize,
                                    buttonColor: Colors.transparent,
                                    borderColor: Colors.white,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.discount);
                                    })
                              ],
                            ),
                          ),
                        ),

                        if (mainData.products.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 24, bottom: 12),
                              child: Text(
                                'Showing ${mainData.products.length.toString()} products',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: DesignConfig.textColor,
                                  fontSize: DesignConfig.mediumFontSize,
                                ),
                              ),
                            ),
                          ),

                        if (mainData.products.isNotEmpty)
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverStaggeredGrid.countBuilder(
                              crossAxisCount: 2,
                              itemCount: mainData.products.length,
                              mainAxisSpacing: 9,
                              crossAxisSpacing: 9,
                              staggeredTileBuilder: (int index) {
                                return new StaggeredTile.count(
                                    1, index.isEven ? 2 : 1);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final item = mainData.products[index];
                                return ProductCard(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.oneProduct);
                                    },
                                    iconOnTap: () {
                                      if (bookmark
                                          .isBookmark(item.id)) {
                                        bookmark
                                            .removeBookmark(item.id);
                                        item.bookmark = false;
                                      } else {
                                        bookmark.addBookmark(item.id, item);
                                        item.bookmark = true;
                                      }


                                    },
                                    icon:(bookmark.isBookmark(item.id))?
                                    Icons.favorite: Icons.favorite_border,
                                    price: '${item.price.toString()} IRR',
                                    discount: (item.offerPrice != null) ?
                                    item.offerPrice.toString()
                                        : '' ,
                                    // timer: "09:09:06",
                                    image: item.image);
                              },
                            ),
                          ),
                      ],
                    ));

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
                        message: mainData.errorMessage,
                        buttonText: "try again",
                        onButtonTap: () {
                          mainData.getData(id: widget.id, refresh: true);
                          mainData.getProduct(id: widget.id, page: page);
                        })
                  ],
                );
            }
          },
        ));
  }
}
