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

    return _firestore
        .collection("trans")
        .where("sender.uid", isEqualTo: uid)
        .snapshots()
        .map((event) {
      //print(event.docs[0].data());
      return event.docs
          .map(
            (e) => Trans.fromJson(e.data()),
          )
          .toList();
    });
  }

  Future<User> getUser(phone) async {
    final user = await _firestore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();

    return User.fromJson(user.docs[0].data());
  }

  Future addTrans(List<Product> products, String destinateur) async {
    var userSender = await getUser(_auth.currentUser!.email!.split("@")[0]);
    var userReceiver = await getUser(destinateur);

    await _firestore.collection("trans").add({
      "sender": userSender.toJson(),
      "receiver": userReceiver.toJson(),
      "products": products.map((e) => e.toJson()).toList(),
      "cost": 0,
      "typeTrans": "Recharge-Client",
      "createdAt": Timestamp.now(),
    });

    final productsClient = await _firestore
        .collection("users")
        .doc(userSender.uid)
        .collection("products")
        .get();

    List<Product> prodClients =
        productsClient.docs.map((e) => Product.fromJson(e.data())).toList();

    for (int i = 0; i < prodClients.length; i++) {
      if (prodClients[i].id == products[i].id) {
        await _firestore
            .collection("users")
            .doc(userReceiver.uid)
            .collection("products")
            .doc(prodClients[i].id)
            .update({
          "quantity": prodClients[i].quantity + products[i].quantity,
        });
      } else {
        await _firestore
            .collection("users")
            .doc(userReceiver.uid)
            .collection("products")
            .add(products[i].toJson());
      }
    }

    final productsSender = await _firestore
        .collection("users")
        .doc(userSender.uid)
        .collection("products")
        .get();

    List<Product> prodDistr =
        productsSender.docs.map((e) => Product.fromJson(e.data())).toList();

    for (int i = 0; i < prodClients.length; i++) {
      if (prodDistr[i].id == products[i].id) {
        await _firestore
            .collection("users")
            .doc(userSender.uid)
            .collection("products")
            .doc(prodClients[i].id)
            .update({
          "quantity": prodClients[i].quantity - products[i].quantity,
        });
      } else {
        await _firestore
            .collection("users")
            .doc(userSender.uid)
            .collection("products")
            .doc(products[i].id)
            .delete();
      }
    }
  }
}
