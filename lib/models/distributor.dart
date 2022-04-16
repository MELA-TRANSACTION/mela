import 'package:mela/models/account.dart';

class Distributor {
  String name;
  String address;
  String lngLat;
  List<Product> products;

  Distributor(
      {required this.products,
      required this.name,
      required this.address,
      required this.lngLat});

  factory Distributor.fromJson(var json) {
    return Distributor(
      name: json['name'],
      products: json['products'],
      address: json['address'],
      lngLat: json['lngLat'],
    );
  }
}
