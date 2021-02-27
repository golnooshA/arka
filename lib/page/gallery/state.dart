import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;

class GalleryController extends ChangeNotifier {
  Status status = Status.loading;
  Status pagination = Status.ready;

  Product productData;
  List<String> images = [];

  int totalPage = 1;

  String errorMessage;

  Future<void> getImages({int id, bool refresh = false}) async  {

    if (!refresh) {

      status = Status.ready;
      notifyListeners();
    }

    if( refresh){

      status = Status.loading;
      productData = null;
    }

    if(productData!=null){

      status = Status.empty;
    }

    String url =
        'http://192.168.1.130:8000/api/products/$id';
    final res = await http.get(url);

    if (res.statusCode == 200) {

      var json = jsonDecode(res.body);



      productData = Product.fromJson(json['product']);
      images = List<String>.from(json['images'] == null ?  [] : json['images']);
      print("*****Images******$images");

      status = Status.ready;
      notifyListeners();
    }
    else{
      throw Exception('***********Failed to load data************');
    }
  }

}
