import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/bookmark/state.dart';
import 'package:wood/page/main/scroll_state.dart';
import 'package:wood/page/main/state.dart';
import 'package:wood/widget/category_slider.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/loading.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class Category extends StatefulWidget {

  final ScrollPageState scrollState;
  final int id;
  final String title;

  const Category({this.id, this.scrollState,this.title});


  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  int page = 1;

  scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      final categoryData = Provider.of<MainController>(context, listen: false);
      if (categoryData.status == Status.ready) {
        page++;
        await categoryData.getProduct(id: widget.id, page: page);
      }
    }
    widget.scrollState.setScroll(scrollController.position.pixels);
  }

  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    final categoryData = Provider.of<MainController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      categoryData.getData(id: widget.id, refresh: true);
      categoryData.getProduct(id: widget.id, page: page);
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
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text(widget.title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
        body: Consumer<MainController>(

          builder: (context, categoryData, child) {

            switch (categoryData.status) {
              case Status.ready:

                return RefreshIndicator(
                  onRefresh: () async {
                    await categoryData.getData(id: widget.id, refresh: true);
                    await categoryData.getProduct(
                        id: widget.id, page: page, refresh: true);
                  },
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      if (categoryData.categories.isNotEmpty)
                        SliverToBoxAdapter(
                          child: CategorySlider(
                            onTap: (){},
                            buttons: categoryData.categories
                                .map((e) => ButtonDynamic(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>ChangeNotifierProvider<MainController>(
                                          create: (_) => MainController(),
                                          child: Category(id: e.id, scrollState: widget.scrollState),
                                        )),
                                  );
                                },
                                text: e.name))
                                .toList(),
                          ),
                        ),

                      if (categoryData.products.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 24, bottom: 12),
                            child: Text(
                              'Showing ${categoryData.products.length.toString()} products',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: DesignConfig.textColor,
                                fontSize: DesignConfig.mediumFontSize,
                              ),
                            ),
                          ),
                        ),

                      if (categoryData.products.isNotEmpty)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 2,
                            itemCount: categoryData.products.length,
                            mainAxisSpacing: 9,
                            crossAxisSpacing: 9,
                            staggeredTileBuilder: (int index) {
                              return new StaggeredTile.count(
                                  1, index.isEven ? 2 : 1);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final item = categoryData.products[index];
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
                                  price: Product.formattedNumber(item.price, suffix: ' IRR'),
                                  discount: (item.offerPrice != null) ?
                                  Product.formattedNumber(item.offerPrice, suffix: ' IRR')
                                      : '' ,
                                  // timer: '09:08:31',
                                  image: item.image);
                            },
                          ),
                        ),

                      ],
                  ),
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
                    Error
                      (message: categoryData.errorMessage,
                        buttonText: "try again",
                        onButtonTap: () {
                          categoryData.getData(id:widget.id,refresh: true);
                          categoryData.getProduct(id:widget.id,page: page);
                        })
                  ],
                );
            }
          },
        ));
  }
}
