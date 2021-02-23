import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/article.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;

class OneBlogController extends ChangeNotifier {
  Status status = Status.loading;
  Status pagination = Status.ready;

  List<Article> articles = [];
  List<String> images = [];

  int totalPage = 1;

  String errorMessage;

  Future<void> getOneArticle({int id, bool refresh = false}) async  {
    if(id == null){
      if ( !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      if( refresh){
        status = Status.loading;
        articles = [];
      }

      if(articles.isEmpty){
        status = Status.empty;
      }

      String url =
          'http://192.168.1.130:8000/api/posts/$id';

      final res = await http.get(url);

      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);

        List postData = json['post'];
        images = List<String>.from(json['image'] == null ? [] : json['image']);

        postData.forEach((element) {
          if(Category.fromJson(element) != null)
            articles.add(Article.fromJson(element));

          else{
            status = Status.empty;
          }
        });

        status = Status.ready;
        notifyListeners();
      }
      else{
        throw Exception('***********Failed to load data************');
      }
    }

    else {
      if (articles.length>0 && !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      if(articles.length>0 && refresh){
        status = Status.loading;
        articles = [];
      }

      if(articles.isEmpty){
        status = Status.empty;
      }

      String url =
          'http://192.168.1.130:8000/api/api/sub-category/CategoryStore/$id';

      final res = await http.get(url);

      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);

        List postData = json['post'];
        postData.forEach((element) {
          if(Category.fromJson(element) != null)
            articles.add(Article.fromJson(element));

          else{
            status = Status.empty;
          }
        });

        status = Status.ready;
        notifyListeners();
      }
      else{
        throw Exception('***********Failed to load data************');
      }
    }
  }

}
