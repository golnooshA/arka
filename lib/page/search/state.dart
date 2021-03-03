import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class SearchStateController extends ChangeNotifier{

  Status status = Status.loading;
  List<Product> products = [];
  String errorMessage;


  Future<void> getProduct({String searchText,bool refresh = false}) async {


    String urlP = 'http://p.kavakwood-app.ir/api/api/search/ProductStore?search=$searchText';
    print("********* URLP **********$urlP");



    final res = await http.get(urlP);

    print("*********RESponse**********$res");


    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);

      print("*********json**********$json");

      List<dynamic> productData = json["products"]["data"];

      print("*********productData**********$productData");


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
