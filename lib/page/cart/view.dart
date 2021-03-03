import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wood/core/helper/ui.dart' as ui;
import 'package:wood/core/router/routes.dart';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/error.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/loading.dart';
import 'package:wood/widget/set_state.dart';
import '../../core/config/design_config.dart';
import 'state.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final discountTextEditingController = TextEditingController();

  final discountController = SetStateController();
  final submitController = SetStateController();

  final discountFocus = FocusNode();
  bool discountLoading = false;
  bool submitLoading = false;
  Settings settings;

  void didChangeDependencies() {
    if (settings == null) {
      settings = Provider.of<Settings>(context, listen: false);
    }
    final cartData = Provider.of<CartController>(context, listen: false);
    if (!cartData.isInit) {
      cartData.init(settings).then((value) {
        if (!cartData.isGet) {
          cartData.get(status: Status.loading);
        }
      });
    } else {
      if (!cartData.isGet) {
        cartData.get(status: Status.loading);
      }
    }
    super.didChangeDependencies();
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
            title: Text('Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: DesignConfig.appBarOptionsColor,
                    fontSize: DesignConfig.appBarTextFontSize,
                    fontWeight: FontWeight.w400))),
        body: Consumer<CartController>(
          builder: (_, cartData, child) {
            switch (cartData.status) {
              case Status.ready:
                return Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 24, bottom: 8),
                              child: Text(
                                'Showing ${cartData.list.length.toString()} products',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: DesignConfig.textColor,
                                  fontSize: DesignConfig.mediumFontSize,
                                ),
                              ),
                            ),
                          ),
                          SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              final item = cartData.list[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: InkWrapper(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.oneProduct);
                                        },
                                        highlightColor:
                                            DesignConfig.highlightColor,
                                        splashColor: DesignConfig.splashColor,
                                        child: DefaultNetworkImage(
                                          url: item.image,
                                          fit: BoxFit.cover,
                                          margin: EdgeInsets.zero,
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 8, right: 8, bottom: 4),
                                            child: Text(
                                              item.name,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: DesignConfig.textColor,
                                                  fontSize:
                                                      DesignConfig.textFontSize,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 4),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    splashColor: DesignConfig
                                                        .splashColor,
                                                    highlightColor:
                                                        DesignConfig
                                                            .highlightColor,
                                                    onPressed: () {
                                                      if (item.count <= 1) {
                                                        cartData
                                                            .removeFromCart(
                                                                item,
                                                                notify: true);
                                                      } else {
                                                        cartData.setToCart(
                                                            item.withCount(
                                                                count:
                                                                    item.count -
                                                                        1),
                                                            notify: true);
                                                      }
                                                    },
                                                    icon: Container(
                                                      width: 24,
                                                      height: 24,
                                                      padding: EdgeInsets.all(4),
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: DesignConfig.appBarOptionsColor)                                            ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: DesignConfig.appBarOptionsColor,
                                                        size: 14,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(
                                                        item.count.toString(),
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: DesignConfig
                                                                .appBarOptionsColor,
                                                            fontSize: DesignConfig
                                                                .textFontSize,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    padding: EdgeInsets.all(4),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: DesignConfig
                                                                .appBarOptionsColor)),
                                                    child: IconButton(
                                                      splashColor: DesignConfig
                                                          .splashColor,
                                                      highlightColor:
                                                          DesignConfig
                                                              .highlightColor,
                                                      onPressed: () {
                                                        if (item.number <=
                                                            item.count) {
                                                          ui.showSnackBar(
                                                              context: context,
                                                              text:
                                                                  'Out of stock');
                                                          return;
                                                        }
                                                        cartData.setToCart(
                                                            item.withCount(
                                                                count:
                                                                    item.count +
                                                                        1),
                                                            notify: true);
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: DesignConfig
                                                            .appBarOptionsColor,
                                                        size: 14,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 8, right: 8, top: 4),
                                            child: Text(
                                              Product.formattedNumber(
                                                  item.getTotalPrice(),
                                                  suffix: ' IRR'),
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: DesignConfig.textColor,
                                                  fontSize: DesignConfig
                                                      .mediumFontSize,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }, childCount: cartData.list.length),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(
                                color: DesignConfig.textColor, height: 32),
                          ),
                          SliverToBoxAdapter(
                              child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price',
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: DesignConfig.appBarOptionsColor,
                                      fontSize: DesignConfig.mediumFontSize,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  Product.formattedNumber(cartData.totalPrice,
                                      suffix: 'IRR'),
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: DesignConfig.textFontSize,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    if (settings.isSoftLogin() && settings.canPurchase())
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: SetState(
                          controller: submitController,
                          builder: () => ButtonText(
                              onTap: submitLoading
                                  ? null
                                  : () async {
                                      submitLoading = true;
                                      submitController.setState();
                                      final res = await cartData.submit();
                                      submitLoading = false;
                                      submitController.setState();
                                      if (res.isOk) {
                                        print(res.text);
                                        launch(res.text);
                                      } else {
                                        ui.showSnackBar(
                                            context: context,
                                            text: res.message);
                                      }
                                    },
                              textColor: DesignConfig.priceColor,
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              text: submitLoading ? 'loading' : 'check out',
                              buttonColor: DesignConfig.checkoutColor,
                              fontSize: DesignConfig.buttonFontSize),
                        ),
                      )
                  ],
                );
                break;

              case Status.loading:
                return Loading();
                break;

              default:
                return Error(
                    message: cartData.errorMessage,
                    buttonText: 'Try again',
                    onButtonTap: cartData.status == Status.empty
                        ? null
                        : () {
                            cartData.get(status: Status.loading);
                          });
            }
          },
        ));
  }
}
