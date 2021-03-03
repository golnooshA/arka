import 'package:wood/core/storage/settings.dart';

class HttpConfig {
  static const String host = 'p.kavakwood-app.ir';

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