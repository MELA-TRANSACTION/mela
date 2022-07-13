import 'package:mela/models/product.dart';

class User {
  late String id;
  late String uid;
  late String name;
  late String phone;
  late List<String> roles;
  late Money balance;

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
    balance = Money.fromJson(json['balance']);
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

class Money {
  num amount;
  String currency;

  Money({required this.currency, required this.amount});

  factory Money.fromJson(var json) {
    return Money(currency: json["currency"], amount: json['amount']);
  }
}
