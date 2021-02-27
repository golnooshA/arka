import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/component/list_view_controller/list_view_controller.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class SearchStateController extends ChangeNotifier{

  Status status = Status.loading;

  List<Product> products = [];

  String errorMessage;

  ListViewController listViewController;



  Future<void> getProduct({String searchText,bool refresh = false}) async {

    if (products.length > 0 && !refresh) {
      status = Status.ready;
      notifyListeners();
    }

    else{
      if (refresh) {
        status = Status.loading;
        products = [];
      }
    }

    notifyListeners();


    String urlP = 'http://192.168.1.130:8000/api/api/search/ProductStore?search=$searchText';
    final res = await http.get(urlP);

    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);
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
      notifyListeners();
    }
    else{
      throw Exception('***********Failed to load data************');
    }

  }


}