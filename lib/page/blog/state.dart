import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/article.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;

class BlogController extends ChangeNotifier {
  Status status = Status.loading;
  Status pagination = Status.ready;

  List<Article> articles = [];

  int totalPage = 1;

  String errorMessage;

  Future<void> getArticle({int id, bool refresh = false}) async {
    if (articles.length > 0 && !refresh) {
      status = Status.ready;
      notifyListeners();
    } else {
      if (refresh) {
        status = Status.loading;
        articles = [];
        totalPage = 1;
        pagination = Status.ready;
      }
    }
    notifyListeners();

    String urlP = 'http://192.168.1.130:8000/api/posts';
    final res = await http.get(urlP);

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      totalPage = json["total"];
      List<dynamic> productData = json["data"];

      productData.forEach((element) {
        articles = productData.map((e) => Article.fromJson(e)).toList();
        if (articles.isEmpty) {
          status = Status.error;
          errorMessage = 'اطلاعات وجود ندارد';
        } else
          status = Status.ready;
      });

      status = Status.ready;
      pagination = Status.ready;
      notifyListeners();
    } else {
      throw Exception('***********Failed to load data************');
    }
  }

}
