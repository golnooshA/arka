import 'package:provider/provider.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/data/status.dart';
import 'package:wood/page/discount/state.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/loading.dart';
import 'package:wood/widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wood/widget/timer_text.dart';
import '../../core/config/design_config.dart';

class Discount extends StatefulWidget {

  final int id;

  const Discount({this.id});


  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController scrollController;
  void initState() {
    scrollController = ScrollController();
    final discountData = Provider.of<DiscountController>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      discountData.getProduct(id: widget.id);
    });
    super.initState();
  }

  
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
        title: Text('Discount',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body:Consumer<DiscountController>(
        builder: (_, discountData, child) {
          switch (discountData.status) {
            case Status.ready:
              return RefreshIndicator(
                  onRefresh: () async {
                    await discountData.getProduct(id: widget.id);
                  },
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      //each category has border if it is selected
                      // borderColor: DesignConfig.titleColor,



                      if (discountData.products.isNotEmpty)
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 24, bottom: 12),
                            child: Text(
                              'Showing ${discountData.products.length.toString()} products',
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: DesignConfig.textColor,
                                fontSize: DesignConfig.mediumFontSize,
                              ),
                            ),
                          ),
                        ),

                      if (discountData.products.isNotEmpty)
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 2,
                            itemCount: discountData.products.length,
                            mainAxisSpacing: 9,
                            crossAxisSpacing: 9,
                            staggeredTileBuilder: (int index) {
                              return new StaggeredTile.count(
                                  1, index.isEven ? 2 : 1);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final item = discountData.products[index];
                              return ProductCard(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.oneProduct, arguments: item);
                                  },
                                  iconOnTap: () {},
                                  icon:Icons.favorite_border,
                                  price: '${item.price.toString()} IRR',
                                  discount: (item.offerPrice != null) ?
                                  item.offerPrice.toString()
                                      : '' ,
                                  timer: TimerText(
                                timeout: item.offerRemaining,
                                builder: (days, hours, minutes, seconds){
                                  return Text(
                                      '${days > 0 ? '$days - ' : ''}${hours > 9 ? hours : '0$hours'}:${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}',
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: days == 0 && hours == 0 && minutes == 0 && seconds == 0 ? DesignConfig.emptyProductColor : DesignConfig.bookmarkColor,
                                          fontSize: DesignConfig.mediumFontSize,
                                          fontWeight: FontWeight.w400)
                                  );
                                },
                              ),
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
                     message: discountData.errorMessage,
                     buttonText: "try again",
                     onButtonTap: () {
                       discountData.getProduct(id: widget.id);
                     }
                 )
                ],
              );
          }
        },
      ));
  }
}
