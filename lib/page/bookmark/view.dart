import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/product.dart';
import 'package:wood/page/bookmark/state.dart';
import 'package:wood/page/main/scroll_state.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/config/design_config.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  ScrollPageState scroll;
  Product productData;

  @override
  Widget build(BuildContext context) {
    final bookmarkState = Provider.of<BookmarkController>(context, listen: false);

    return Scaffold(
        backgroundColor: DesignConfig.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
          elevation: 0,
          centerTitle: true,
          title: Text('Favorite',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: DesignConfig.appBarOptionsColor,
                  fontSize: DesignConfig.appBarTextFontSize,
                  fontWeight: FontWeight.w400)),
        ),
        body: Consumer<BookmarkController>(builder: (_, bookmarkState, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 12),
                  child: Text(
                    'Showing ${bookmarkState.product.length} products',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.mediumFontSize,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  itemCount: bookmarkState.product.length,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 9,
                  staggeredTileBuilder: (int index) {
                    return new StaggeredTile.count(1, index.isEven ? 2 : 1);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item = bookmarkState.product[index];
                    return ProductCard(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.oneProduct);
                        },
                        iconOnTap: () {

                          if (bookmarkState
                              .isBookmark(item.id)) {
                            bookmarkState
                                .removeBookmark(item.id);
                            item.bookmark = false;
                          } else {
                            bookmarkState.addBookmark(item.id, item);
                            item.bookmark = true;
                          }
                        },
                        icon: Icons.favorite,
                        price: item.price.toString(),
                        discount: (item.offerPrice != null) ?
                        item.offerPrice.toString()
                            : '' ,
                        // timer: "09:09:06",
                        image: item.image);
                  },
                ),
              )
            ],
          );
        }));
  }
}
