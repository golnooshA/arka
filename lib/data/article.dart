
import 'package:wood/core/config/http_config.dart';

class Article {
  final int id;
  final String name;
  final String description;
  final String fileType;
  final String fileName;
  final String thumbnail;
  final String createdAt;
  final String updatedAt;
  final String stripDesc;
  final String image;
  final String video;

  static const fileTypeMp4 = 'mp4';

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        fileType = json['file_type'],
        fileName = json['file_name'],
        thumbnail = json['thumbnail'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        image = json['image'] == null ? null : HttpConfig.url(json['image'], isApi: false),
        stripDesc = json['strip_desc'],
        video = json['video'];

  Map<String, dynamic> toJson() =>
      {
        'id': id.toString(),
        'name': name,
        'description': description,
        'fileType': fileType,
        'fileName': fileName,
        'image': image,
        'thumbnail': thumbnail,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'stripDesc': stripDesc,
        'video': video,
      };

  bool hasVideo(){
    return fileType == fileTypeMp4 && video != null;
  }
}
