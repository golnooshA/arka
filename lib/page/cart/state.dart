import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:wood/core/config/http_config.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class CartController extends ChangeNotifier{

  Status status = Status.loading;
  Status pagination = Status.ready;

  List<Product> products = [];
  List<int> ids;

  int totalPrice = 0;
  int productPrice = 0;

  Map<int, Product> storageCart = {};

  int totalPage =1;

  String errorMessage;

  Future<void> getProduct({int id, bool refresh = false}) async {

    if (products.length>0 && !refresh) {
      status = Status.ready;
      notifyListeners();
    }

    if(ids == null || ids.isEmpty){
      status = Status.empty;
      errorMessage = "Cart is empty";
      notifyListeners();
      return;
    }

    else {
      if (refresh) {
        status = Status.loading;
        products = [];
        totalPage = 1;
        pagination = Status.ready;
      }
    }
    notifyListeners();


    final res = await PostRequest(
        url: HttpConfig.url('api/store-product-ids'),
        reqBody: {
          'ids': ids
        }
    ).responseJson();

    errorMessage =null;

    // final res = await http.get(urlP);

    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);
      totalPage = json["products"]["total"];
      List<dynamic> productData = json["products"]["data"];

      productData.forEach((element) {
        products = productData.map((e) => Product.fromJson(e)).toList();
        if(products.isEmpty) {
          status = Status.error;
          errorMessage = 'اطلاعات وجود ندارد';
          notifyListeners();
          return;
        }
        else {
          productData = [];
          status = Status.ready;
          notifyListeners();
          return;
        }
      });

      status = Status.ready;
      pagination = Status.ready;
      notifyListeners();
    }
    else{
      throw Exception('***********Failed to load data************');
    }
  }


}