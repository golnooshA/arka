class User {
  final int id;
  final String name;
  final int number;
  final String city;
  final String province;
  final String postalCode;
  final String address;
  final String accessToken;
  final String httpMessage;

  const User(
      {this.id,
      this.name,
      this.city,
      this.number,
      this.province,
      this.address,
      this.postalCode,
      this.accessToken,
      this.httpMessage});

  User.fromJson(Map map, {String accessToken, String httpMessage})
      : id = map['id'],
        name = map['name'],
        number = map['number'],
        province = map['province'],
        address = map['address'],
        city = map['city'],
        postalCode = map['postal_code'],
        accessToken = accessToken ?? map['access_token'],
        httpMessage = httpMessage;

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'city': city,
      'province': province,
      'address': address,
      'postal_code': postalCode,
      'access_token': accessToken
    };
  }

  User withData(
      {int id,
      String name,
      String accessToken,
      String address,
      int city,
      int province,
      int postalCode}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        accessToken: accessToken ?? this.accessToken,
        city: city ?? this.city,
        province: province ?? this.province,
        address: address ?? this.address,
        postalCode: postalCode ?? this.postalCode,
        httpMessage: httpMessage);
  }
}
