import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mela/models/user.dart';

class Trans {
  late int createdAt;
  late int cost;
  late String typeTrans;
  late User sender;
  late User receiver;
  late String id;
  late Money amount;
  late String uid;

  Trans({
    required this.createdAt,
    required this.amount,
    required this.cost,
    required this.typeTrans,
    required this.id,
    required this.receiver,
    required this.sender,
    required this.uid,
  });

  Trans.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    amount = Money.fromJson(json['amount']);
    cost = json['cost'];
    typeTrans = json['transType'];
    uid = json['owner'];
    id = json['id'];
    sender = User.fromJson(json['sender']);
    receiver = User.fromJson(json['receiver']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['amount'] = amount;
    data['cost'] = cost;
    data['typeTrans'] = typeTrans;
    data['owner'] = uid;
    return data;
  }
}
