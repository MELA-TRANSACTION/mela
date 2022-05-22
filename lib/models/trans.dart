import 'package:mela/models/product.dart';
import 'package:mela/models/user.dart';

class Trans {
  late String id;
  late User user;
  late Product product;
  late String status;
  late int cost;
  late int quantityIn;
  late int quantityOut;
  late int createdAt;

  Trans({
    required this.id,
    required this.quantityIn,
    required this.cost,
    required this.quantityOut,
    required this.user,
    required this.createdAt,
    required this.status,
  });

  Trans.fromJson(var json) {
    id = json['id'].toString();
    product = Product.fromJson(json['product']);

    cost = json['cost'];
    createdAt = json['createdAt'];
    status = json['status'];
    quantityIn = json['quantityIn'] ?? 0;
    quantityOut = json['quantityOut'] ?? 0;
    user = User.fromJson(json['user']);
    //company = json['company']['uid'];
  }
}
