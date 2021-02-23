import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class DiscountController extends ChangeNotifier{

  Status status = Status.loading;
  Status pagination = Status.ready;

  List<Product> products = [];

  int totalPage =1;

  String errorMessage;

  Future<void> getProduct({bool refresh = false}) async {

    if ( products.length>0 && !refresh) {
      status = Status.ready;
      notifyListeners();
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



    String urlP = 'http://192.168.1.130:8000/api/api/offer-products';
    final res = await http.get(urlP);

    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);
      totalPage = json["products"]["total"];
      List<dynamic> productData = json["products"]["data"];

      productData.forEach((element) {
        products = productData.map((e) => Product.fromJson(e)).toList();
        if(products.isEmpty) {
          status = Status.error;
          errorMessage = 'اطلاعات وجود ندارد';
        }
        else
          status = Status.ready;
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