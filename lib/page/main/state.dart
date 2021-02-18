import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wood/data/category.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';
import 'package:http/http.dart' as http;


class MainController extends ChangeNotifier{

  Status status = Status.loading;
  Status pagination = Status.ready;


  List<Category> categories = [];
  List<Product> products = [];

  int totalPage =1;

  String errorMessage;

  Future<void> getData({int id, bool refresh = false}) async {
    if(id == null){
      if (categories.length>0 && !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      if(categories.length>0 && refresh){
        status = Status.loading;
        categories = [];
      }

      if(categories.isEmpty){
        status = Status.empty;
      }

      String url =
          'https://p.kavakwood-app.ir/api/api/main-category/CategoryStore';

      final res = await http.get(url);

      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);

        List catData = json['categories'];
        catData.forEach((element) {
          if(Category.fromJson(element) != null)
            categories.add(Category.fromJson(element));

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
      if (categories.length>0 && !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      if(categories.length>0 && refresh){
        status = Status.loading;
        categories = [];
      }

      if(categories.isEmpty){
        status = Status.empty;
      }

      String url =
          'https://p.kavakwood-app.ir/api/api/main-category/CategoryStore';

      final res = await http.get(url);

      if (res.statusCode == 200) {
        var json = jsonDecode(res.body);

        List catData = json['categories'];
        catData.forEach((element) {
          if(Category.fromJson(element) != null)
            categories.add(Category.fromJson(element));

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


  Future<void> getProduct({int id, int page, bool refresh = false}) async {

    if(id == null){
      if (page == 1 && products.length>0 && !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      else {
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



      String urlP = 'https://p.kavakwood-app.ir/api/api/main-category/CategoryStore?page=$page';
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

    else {
      if (page == 1 && products.length>0 && !refresh) {
        status = Status.ready;
        notifyListeners();
      }

      else {
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


      String urlP = 'https://p.kavakwood-app.ir/api/api/main-category/CategoryStore?page=$page';
      final res = await http.get(urlP);

      if (res.statusCode == 200) {

        var json = jsonDecode(res.body);
        totalPage = json["products"]['total'];
        List<dynamic> productData = json["products"]['data'];

        if(totalPage >= page ){
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


}