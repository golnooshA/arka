import 'dart:collection';
import 'package:wood/data/product.dart';
import 'package:hive/hive.dart';

class Products {

  static const imagesBoxName = 'images';

  List<Product> get list => _list;
  List<Product> _list = [];

  Map<int, List<String>> get images => _images;
  Map<int, List<String>> _images = {};

  List<int> get keys => keys;
  List<int> _keys = [];

  Map<int, int> _idToKey = {};

  void init(){

  }

  Future<void> add(String boxName, Product product, {bool sync = true}) async {
    (await Hive.openBox(boxName)).add(product.toJson());
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<void> putImages(int productId, List<String> images, {bool syncImages = true}) async {
    (await Hive.openBox(imagesBoxName)).put(productId, images);
    if(syncImages){
      await this.syncImages();
    }
  }

  Future<void> put(String boxName, Product product, {bool sync = true}) async {
    await this.sync(boxName);
    (await Hive.openBox(boxName)).put(_idToKey[product.id], product.toJson());
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<void> delete(String boxName, int id, {bool sync = true}) async {
    (await Hive.openBox(boxName)).delete(id);
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<void> deleteAll(String boxName, {bool sync = true}) async {
    final b = await Hive.openBox(boxName);
    await b.deleteAll(b.keys);
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<void> addAll(String boxName, List<Product> products, {bool sync = true}) async {
    await addAllMap(boxName, products.map((e) => e.toJson()).toList(growable: false), sync: false);
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<void> addAllMap(String boxName, List<Map> products, {bool sync = true}) async {
    (await Hive.openBox(boxName)).addAll(products);
    if(sync){
      await this.sync(boxName);
    }
  }

  Future<List<Map>> getAllMap(String boxName) async {
    final b = await Hive.openBox(boxName);
    return List<Map>.from(b.values);
  }

  Future<Map<int, List<String>>> getAllImages() async {
    final b = await Hive.openBox(imagesBoxName);
    return Map<int, List<String>>.from(b.toMap());
  }

  Future<List<Product>> getAll(String boxName) async {
    return (await getAllMap(boxName)).map((e) => Product.fromJson(e)).toList(growable: false);
  }

  Future<void> sync(String boxName, {bool syncImages = false}) async {
    _list = await getAll(boxName);
    _keys = List<int>.from((await Hive.openBox(boxName)).keys);
    for(int i=0, len=_list.length; i<len; i++){
      _idToKey[_list[i].id] = _keys[i];
    }
    if(syncImages){
      await this.syncImages();
    }
  }

  Future<void> syncImages() async {
    _images = await getAllImages();
  }


}