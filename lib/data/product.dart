
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
  final int price;
  final int number;
  final String image;
  final String stripDesc;
  bool cart ;

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
        image = json['image'],
        stripDesc = json['strip_desc'],
        cart = false;

  Map<String, dynamic> toJson() =>
      {
        'id': id.toString(),
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'cart': cart,
        'offerDate': offerDate,
        'offerDateFarsi': offerDateFarsi,
        'offerPrice': offerPrice,
        'thumbnail': thumbnail,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'stripDesc': stripDesc,
        'number': number,
      };

}
