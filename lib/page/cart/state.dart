import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/result.dart';
import 'package:wood/data/status.dart';


class CartController extends ChangeNotifier{

  Status status = Status.loading;
  String errorMessage;
  List<Product> list;
  List<int> ids;
  bool isGet = false;
  bool isInit = false;
  int productsPrice = 0;
  int discountPrice = 0;
  int totalPrice = 0;
  int totalCount = 0;
  Map<int, Product> storageCart = {};
  String discountCode;
  Settings settings;
  Language language;

  Future<void> init(Settings settings, {bool notify = false}) async {
    this.language = language;
    this.settings = settings;
    list = [];
    await _setMapCart();
    isInit = true;
    if(notify){
      notifyListeners();
    }
  }

  Future<void> get({Status status}) async {

    if(ids == null || ids.isEmpty){
      this.status = Status.empty;
      errorMessage = 'cart is empty';
      notifyListeners();
      return;
    }

    if(status != null && status != this.status){
      this.status = status;
      notifyListeners();
    }

    final res = await PostRequest(
        url: HttpConfig.url('api/store-product-ids'),
        reqBody: {
          'ids': ids
        }
    ).responseJson();

    errorMessage = null;


    switch(res.status){
      case ReqStatus.success:
        if(res.body is! Map) {
          errorMessage = language.unknownError;
          status = Status.error;
          notifyListeners();
          return;
        }

        final Map body = res.body;

        if(body['products'] != null){
          list = (body['products'] as List).map((e) {
            return Product.fromJson(e, count: storageCart[e['id']] == null ? 0 : storageCart[e['id']].count);
          }).toList();

          calculatePrices();

          if(list.isEmpty){
            await clearCartStorage();
            this.status = Status.empty;
            errorMessage = 'cart is empty';
            notifyListeners();
            return;
          }

        } else {
          list = [];
          this.status = Status.empty;
          errorMessage = 'cart is empty';
          notifyListeners();
          return;
        }

        this.status = Status.ready;
        isGet = true;
        notifyListeners();
        break;

      default:
        if (res.body is Map && res.body.containsKey('message')) {
          errorMessage = res.body['message'].toString();
        } else {
          errorMessage = language.unknownError;
        }
        this.status = Status.error;
        notifyListeners();
        return;
    }
  }

  Future<void> _setMapCart() async {
    final map = await getCartStorage();
    ids = [];
    storageCart = {};
    totalCount = 0;
    map.forEach((k, p) {
      storageCart[p['id']] = Product.fromJson(p);
      ids.add(p['id']);
      totalCount += storageCart[p['id']].count ?? 1;
    });
  }

  void _setTotalCount(){
    totalCount = 0;
    storageCart.forEach((k, p) {
      totalCount += p.count ?? 1;
    });
  }

  void calculatePrices({bool notify = false}){
    productsPrice = 0;
    list.forEach((product) {
      productsPrice += product.getTotalPrice();
    });
    totalPrice = productsPrice;
    if(totalPrice < 0){
      totalPrice = 0;
    }
    if(notify){
      notifyListeners();
    }
  }

  Future<void> setToCart(Product product, {bool notify = false}) async {
    if(await isInCartStorage(product.id)){
      await setToCartStorage(product.id, product.count ?? 1);
      if(storageCart.containsKey(product.id)){
        storageCart[product.id] = product;
      }
      for(int i=0, len=list.length; i<len; i++){
        if(list[i].id == product.id){
          list[i] = product;
          break;
        }
      }
      _setTotalCount();
    } else {
      await setToCartStorage(product.id, product.count ?? 1);
      await _setMapCart();
      isGet = false;
    }
    calculatePrices(notify: notify);
  }

  Future<void> removeFromCart(Product product, {bool notify = false}) async {
    await removeFromCartStrage(product.id);
    list.removeWhere((element) => element.id == product.id);
    await _setMapCart();
    if(ids.isEmpty){
      status = Status.empty;
      errorMessage = 'cart is empty';
    }
    calculatePrices(notify: notify);
  }

  Future<void> clearCart({bool notify = false}) async {
    await clearCartStorage();
    list = [];
    await _setMapCart();
    if(ids.isEmpty){
      status = Status.empty;
      errorMessage = 'cart is empty';
    }
    calculatePrices(notify: notify);
  }

  Future<void> setToCartStorage(int id, int count) async {
    final Box box = await Hive.openBox('cart');
    box.put(id, {
      'id': id,
      'count': count
    });
  }

  Future<void> removeFromCartStrage(int id) async {
    final Box box = await Hive.openBox('cart');
    await box.delete(id);
  }

  Future<void> clearCartStorage() async {
    final Box box = await Hive.openBox('cart');
    await box.deleteAll(box.keys);
  }

  Future<Map<String, dynamic>> getFromCartStorage(int id) async {
    final Box box = await Hive.openBox('cart');
    return box.get(id);
  }

  Future<Map<int, Map<String, dynamic>>> getCartStorage() async {
    final Box box = await Hive.openBox('cart');
    final Map<int, Map<String, dynamic>> map = {};
    box.values.forEach((element) {
      map[element['id']] = Map<String, dynamic>.from(element);
    });
    return map;
  }

  Future<bool> isInCartStorage(int id) async {
    final Box box = await Hive.openBox('cart');
    return box.containsKey(id);
  }

  Future<Result> submit() async {
    final Map<String, Map<String, dynamic>> products = {};

    list.forEach((p) {
      products[p.id.toString()] = {
        'name': p.name ?? 'product',
        'count': p.count ?? 1
      };
    });

    final Map<String, dynamic> jsonCart = {
      'products': products
    };

    final res = await PostRequest(
        url: HttpConfig.url('store/transaction/gateway'),
        reqBody: {
          'json_cart': jsonCart
        },
        headers: {
          "Authorization": "Bearer ${settings?.user?.accessToken}",
          "Content-Type": "application/json"
        }
    ).responseJson();
    settings.checkAndLogoutOnResponse(res);

    switch(res.status){
      case ReqStatus.success:
        if(res.body is Map && res.body.containsKey('link')){
          return Result(
              isOk: true,
              text: res.body['link']
          );
        } else {
          return Result(
              isOk: false,
              message: res.body is Map && res.body.containsKey('message') ? res.body['message'] : language.unknownError
          );
        }
        break;

      default:
        return Result(
            isOk: false,
            message: res.body is Map && res.body.containsKey('message') ? res.body['message'] : language.unknownError
        );
    }
  }
}