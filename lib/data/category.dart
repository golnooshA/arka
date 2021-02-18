
class Category {
  final int id;
  final String name;
  final String image;
  final int parentId;
  final String thumbnail;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        thumbnail = json['thumbnail'],
        parentId = json['parent_id'];


  Map<String, dynamic> toJson() =>
      {
        'id': id.toString(),
        'name': name,
        'image': image,
        'thumbnail': thumbnail,
        'parentId': parentId};

}
