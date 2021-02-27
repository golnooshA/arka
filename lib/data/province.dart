import 'city.dart';

class Province {
  final String name;
  final List<City> cities;

  const Province({this.cities, this.name});

  Province.fromJson(Map json)
      : name = json['name'],
        cities =
        json['cities'] == null ? [] : List<City>.from(json['cities']);
}
