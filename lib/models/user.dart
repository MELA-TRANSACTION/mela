import 'package:mela/models/product.dart';

class User {
  late String id;
  late String uid;
  late String name;
  late String phone;
  late List<String> roles;
  List<Product>? balance;

  User(
      {required this.id,
      required this.name,
      required this.roles,
      required this.phone,
      required this.balance,
      required this.uid});

  User.fromJson(var json) {
    id = json['id'];
    name = json['name'];
    roles = List.from(json['roles']);
    phone = json['phone'];
    uid = json['uid'];

    if (json['balance'] != null) {
      balance = <Product>[];
      json['balance'].forEach((v) {
        balance!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phone": phone,
      "roles": roles,
    };
  }
}
