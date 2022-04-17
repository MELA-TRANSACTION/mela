import 'package:mela/models/account.dart';

class Distributor {
  String place;
  String address;
  String city;
  String owner;
  String phone;

  Distributor({
    required this.place,
    required this.city,
    required this.address,
    required this.owner,
    required this.phone,
  });

  factory Distributor.fromJson(var json) {
    return Distributor(
        place: json['place'],
        owner: json['owner'],
        address: json['address'],
        city: json['city'],
        phone: json['phone']);
  }
}
