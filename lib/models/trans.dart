
import 'package:mela/models/product.dart';
import 'package:mela/models/user.dart';

class Trans {
  late String id;
  late User user;
  late Product product;
  late String type;
  late int cost;
  late int quantityIn;
  late int quantityOut;
  late double createdAt;

  Trans({
    required this.id,
    required this.quantityIn,
    required this.cost,
   required this.quantityOut,
   required this.user,
    required this.createdAt,
    required this.type,
  });

  Trans.fromJson(var json) {
    id = json['id'].toString();
    product = Product.fromJson(json['product']);

    cost = json['cost'];
    createdAt = json['createdAt'];
    type = json['typeTrans'];
    quantityIn = json['quantityIn'] ?? 0;
    quantityIn = json['quantityOut'] ?? 0;
    user = User.fromJson(json['user']);
    //company = json['company']['uid'];
  }
}
