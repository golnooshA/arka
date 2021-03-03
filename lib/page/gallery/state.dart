import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/component/http_request/http_request.dart';
import 'package:http/http.dart' as http;
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';


class GalleryController extends ChangeNotifier {
  Status status = Status.loading;

  Product productData;
  List<String> images = [];

  String errorMessage;

  Future<void> getImages({int id, Status status,  bool refresh = false}) async {
    // if (!refresh) {
    //   status = Status.ready;
    //   notifyListeners();
    // }
    //
    // if (refresh) {
    //   status = Status.loading;
    //   productData = null;
    // }
    //
    // if (productData != null) {
    //   status = Status.empty;
    // }
    // notifyListeners();

    String url =
        'http://p.kavakwood-app.ir/api/products/$id';

    print("******URL******$url");

    final res = await http.get(url);

    print("******RES******$res");


    var json = jsonDecode(res.body);

    print("******Json******$json");



    if (json is! Map || json['product'] == null) {
      errorMessage = 'no data';
      status = Status.error;
      notifyListeners();
      return;
    }
    productData = Product.fromJson(json['product']);
    images =
    List<String>.from(json['images'] == null ? [] : json['images']);

    print("******images******$images");
    print("******product******$productData");
    this.status = Status.ready;
    notifyListeners();

  }

}
