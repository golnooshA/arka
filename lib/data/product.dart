
import 'package:wood/core/config/http_config.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String offerDate;
  final int offerPrice;
  final String offerDateFarsi;
  final String thumbnail;
  final String createdAt;
  final String updatedAt;
  final String thickness;
  final String size;
  final String weight;
  final int price;
  final int number;
  final String image;
  final String stripDesc;
  final Duration offerRemaining;
  bool cart ;
  bool bookmark;
  final int stock;


  static String formattedNumber(int number, {String suffix = ''}){
    final numStr = '$number';
    String finalStr = '';
    for(int i=numStr.length-1, c=0; i>=0; i--, c++){
      finalStr = '${numStr[i]}${c % 3 == 0 && c != 0 ? ',' : ''}$finalStr';
    }
    return finalStr + suffix;
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        offerDate = json['offer_date'],
        offerDateFarsi = json['offer_date_farsi'],
        offerPrice = json['offer_price'],
        thumbnail = json['thumbnail'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        number = json['number'],
        weight = json['weight'],
        size = json['size'],
        thickness = json['thickness'],
        stock = json['stock'],
        image = json['image'] == null ? null : HttpConfig.url(json['image'], isApi: false),
        stripDesc = json['strip_desc'],
        offerRemaining = json['offer_remaining'] == null ? null : Duration(seconds: json['offer_remaining']),
        cart = false,
  bookmark = false;

  Map<String, dynamic> toJson() =>
      {
        'id': id.toString(),
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'cart': cart,
        'thickness': thickness,
        'size': size,
        'weight': weight,
        'offerDate': offerDate,
        'offerDateFarsi': offerDateFarsi,
        'offerPrice': offerPrice,
        'thumbnail': thumbnail,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'stripDesc': stripDesc,
        'number': number,
        'offerRemaining': offerRemaining,
        'bookmark': bookmark,
        'stock' : stock
      };

}
