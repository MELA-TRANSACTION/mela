import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/client.dart';
import 'package:mela/models/distributor.dart';

class Trans {
  late String id;
  String? company;
  Distributor? distributor;
  Client? client;
  late Product products;
  late String type;
  late int cost;
  late int quantity;
  late Timestamp createdAt;

  Trans({
    required this.id,
    required this.products,
    required this.cost,
    this.distributor,
    this.client,
    this.company,
    required this.createdAt,
    required this.type,
    required this.quantity,
  });

  Trans.fromJson(var json) {
    id = json['id'].toString();
    products = Product.fromJson(json['products']);

    cost = json['cost'];
    createdAt = json['createdAt'];
    type = json['typeTrans'];
    quantity = json['quantity'];
    distributor = Distributor.fromJson(json['distributor']);
    client = json["client"] != null ? Client.fromJson(json['client']) : null;
    company = json['company']['uid'];
  }
}
