import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/article.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;

class OneBlogController extends ChangeNotifier {
  Status status = Status.loading;
  Status pagination = Status.ready;

  Article postData;
  List<String> images = [];

  int totalPage = 1;

  String errorMessage;

  Future<void> getOneArticle({int id, bool refresh = false}) async  {

    if (!refresh) {
      print("************if one************");

      status = Status.ready;
      notifyListeners();
    }

    if( refresh){
      print("************if two************");

      status = Status.loading;
      postData = null;
    }

    if(postData!=null){
      print("************if three empty************");

      status = Status.empty;
    }

    String url =
        'http://p.kavakwood-app.ir/api/posts/$id';
    final res = await http.get(url);

    if (res.statusCode == 200) {
      print("************res.statusCode************$res");


      var json = jsonDecode(res.body);

      print("************json************$json");


      postData = Article.fromJson(json['post']);
      images = List<String>.from(json['image'] == null ?  [] : json['image']);

      status = Status.ready;
      notifyListeners();
    }
    else{
      throw Exception('***********Failed to load data************');
    }
  }

}
