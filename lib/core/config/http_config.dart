import 'package:wood/core/storage/settings.dart';

class HttpConfig {
  static const String host = '192.168.1.130:8000';
  //static const String siteHost = '';

  static Uri uri(String path, {bool isApi = true, Map<String, String> queryParameters = const {}}){
    queryParameters = {
      'language': Settings.languageCode ?? 'en',
      ...queryParameters
    };
    return Uri.http(host, isApi ? '/api/' + path : path, queryParameters);
  }

  static String url(String path, {bool isApi = true, Map<String, String> queryParameters = const {}, bool replaceHash = false}){
    final u = uri(path, isApi: isApi, queryParameters: queryParameters).toString();
    return replaceHash ? u.replaceAll('%23', '#') : u;
  }
}