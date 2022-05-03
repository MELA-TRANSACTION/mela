import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/client.dart';

class Trans {
  late String id;
  String? company;
  Client? sender;
  Client? receiver;
  late Product products;
  late String type;
  late int cost;
  late int quantity;
  late Timestamp createdAt;

  Trans({
    required this.id,
    required this.products,
    required this.cost,
    this.receiver,
    this.sender,
    this.company,
    required this.createdAt,
    required this.type,
    required this.quantity,
  });

  Trans.fromJson(var json) {
    id = json['id'].toString();
    products = Product.fromJson(json['product']);

    cost = json['cost'];
    createdAt = json['createdAt'];
    type = json['typeTrans'];
    quantity = json['quantity'] ?? 0;
    sender = json['sender'] == null ? null : Client.fromJson(json['sender']);
    receiver =
        json["receiver"] != null ? Client.fromJson(json['receiver']) : null;
    //company = json['company']['uid'];
  }
}
