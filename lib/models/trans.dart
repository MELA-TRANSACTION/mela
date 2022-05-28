import 'package:mela/models/product.dart';
import 'package:mela/models/user.dart';

class Trans {
  late String id;
  late User user;
  late Product product;
  late String status;
  late int cost;
  late int quantity;

  late int createdAt;

  Trans({
    required this.id,
    required this.cost,
    required this.quantity,
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
    quantity = json['quantity'] ?? 0;

    user = User.fromJson(json['owner']);
    //company = json['company']['uid'];
  }
}
