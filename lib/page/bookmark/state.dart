import 'package:flutter/material.dart';
import 'package:wood/data/product.dart';
import 'package:wood/data/status.dart';


class BookmarkController extends ChangeNotifier {
  Map<int, bool> bookmark = {};

  List<Product> product = [];

  Status status = Status.loading;



  addBookmark(int id, Product productData) {
    bookmark[id] = true;
    product.add(productData);
    // user.add(user[id]);
    notifyListeners();
  }

  removeBookmark(int id) {
    bookmark[id] = false;
    for(int i=0; i<product.length; i++){
      if(product[i].id == id){
        product.removeAt(i);
        break;
      }
    }

    // user.remove(user[id]);
    notifyListeners();
  }

  isBookmark(int id) {
    if (bookmark != null && bookmark.containsKey(id) && bookmark[id]) {
      return true;
    }
    return false;
  }
}
