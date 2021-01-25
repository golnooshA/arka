
//currently only works with one argument
import 'package:wood/core/config/http_config.dart';

class RouteParser {
  final String name;
  final int arg;

  const RouteParser({this.name, this.arg});

  factory RouteParser.parse(String route){
    assert(route != null);

    String name;
    String arg;
    if(route.contains('?')){
      route = route.split('?')[0];
    }
    final parts = route.split('/');
    parts.removeWhere((element) {
      element = element.trim();
      switch(element){
        case 'https:':
          return true;

        case 'http:':
          return true;

        case HttpConfig.host:
          return true;

        case HttpConfig.siteHost:
          return true;

        case '#':
          return true;

        case '':
          return true;

        default:
          return false;
      }
    });

    switch(parts.length){
      case 1:
        name = parts[0];
        break;

      case 0:
        break;

      default:
        name = parts[0];
        arg = parts[1];
    }

    return RouteParser(
      name: '/' + (name ?? ''),
      arg: arg == null ? null : int.tryParse(arg.trim())
    );
  }
}