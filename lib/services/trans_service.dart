import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';
import 'package:mela/models/user.dart';

class TransService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Trans>> getTrans() {
    String uid = _auth.currentUser!.uid;

    var transSended = _firestore
        .collection("users")
        .doc(uid)
        .collection("trans")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              print(e.data());
              return Trans.fromJson(e.data());
            }).toList());

    return transSended;
  }

  Future<User> getUser(phone) async {
    final user = await _firestore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();

    return User.fromJson(user.docs[0].data());
  }

  Future<void> rechargerClient(
    Product product,
    String client,
  ) async {
    await addTrans(product, client, "Recharge", 0);
  }

  Future<void> addTrans(
      Product product, String destinateur, String transType, int cost) async {
    var userSender = await getUser(_auth.currentUser!.email!.split("@")[0]);
    var userReceiver = await getUser(destinateur);

    await _firestore
        .collection("users")
        .doc(userSender.uid)
        .collection("trans")
        .add({
      "sender": userSender.toJson(),
      "receiver": userReceiver.toJson(),
      "product": product.toJson(),
      "cost": cost,
      "typeTrans": "sent-" + transType,
      "createdAt": Timestamp.now(),
    });

    await _firestore
        .collection("users")
        .doc(userReceiver.uid)
        .collection("trans")
        .add({
      "sender": userSender.toJson(),
      "receiver": userReceiver.toJson(),
      "product": product.toJson(),
      "cost": cost,
      "typeTrans": "received-" + transType,
      "createdAt": Timestamp.now(),
    });

    await _firestore.collection("trans").add({
      "sender": userSender.toJson(),
      "receiver": userReceiver.toJson(),
      "product": product.toJson(),
      "cost": cost,
      "typeTrans": transType,
      "createdAt": Timestamp.now(),
    });
  }
}
