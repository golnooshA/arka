
import 'package:wood/core/storage/settings.dart';

class HttpConfig {
  static const String host = 'panel.raytalhaq.app';
  static const String siteHost = 'raytalhaq.app';

  static Uri uri(String path, {bool isApi = true, Map<String, String> queryParameters = const {}}){
    queryParameters = {
      'language': Settings.languageCode ?? 'en',
      ...queryParameters
    };
    return Uri.https(host, isApi ? '/api/' + path : path, queryParameters);
  }

  static String url(String path, {bool isApi = true, Map<String, String> queryParameters = const {}, bool replaceHash = false}){
    final u = uri(path, isApi: isApi, queryParameters: queryParameters).toString();
    return replaceHash ? u.replaceAll('%23', '#') : u;
  }
}