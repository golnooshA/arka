import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class SearchStateController extends ChangeNotifier{

  Status status = Status.loading;
  Status pagination = Status.ready;

  List<Product> products = [];

  int totalPage =1;

  String errorMessage;


  Future<void> getProduct({String searchText,int page, bool refresh = false}) async {

    if (page == 1 && products.length > 0 && !refresh) {
      status = Status.ready;
      notifyListeners();
    }

    else{
      if (refresh) {
        status = Status.loading;
        products = [];
        page = 1;
        totalPage = 1;
        pagination = Status.ready;
      }

      if (page > 1 && page >= totalPage) {
        pagination = Status.ready;
      }

      if (page > totalPage) {
        pagination = Status.ready;
        return;
      }
    }

    notifyListeners();


    String urlP = 'http://192.168.1.130:8000/api/api/search/ProductStore?search=$searchText';
    final res = await http.get(urlP);

    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);
      totalPage = json["products"]["total"];
      List<dynamic> productData = json["products"]["data"];

      if(totalPage >= page){
        productData.forEach((element) {
          products = productData.map((e) => Product.fromJson(e)).toList();
          if(products.isEmpty) {
            status = Status.error;
            errorMessage = 'اطلاعات وجود ندارد';
          }
          else
            status = Status.ready;
        });
      }
      status = Status.ready;
      pagination = Status.ready;
      notifyListeners();
    }
    else{
      throw Exception('***********Failed to load data************');
    }

  }


}