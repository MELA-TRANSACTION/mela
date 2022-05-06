import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:mela/models/product.dart';
import 'package:mela/models/user.dart';
import 'package:uuid/uuid.dart';

class TransClientService {
  var uuid = Uuid();
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Product>> getBalance() {
    String uid = _auth.currentUser!.uid;
    final d = _firestore
        .collection("users")
        .doc(uid)
        .collection("products")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Product.fromJson(e.data())).toList());

    return d;
  }

  Future<List<Product>> getProducts(uid) async {
    final d = await _firestore
        .collection("users")
        .doc(uid)
        .collection("products")
        .get();
    var t = d.docs.map((e) => Product.fromJson(e.data())).toList();

    return t;
  }

  Future<User> getUser(phone) async {
    final user = await _firestore
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();

    return User.fromJson(user.docs[0].data());
  }

  Future<void> shareBeer(Product product, String destinateur) async {
    await addTrans(product, destinateur, "Share", 500);
  }

  Future<void> withdrawBeer(Product product, String destinateur) async {
    await addTrans(product, destinateur, "Withdraw", 500);
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

    await addOrUpdateProduct(product, destinateur);
  }

  Future<void> addOrUpdateProduct(Product product, String destinateur) async {
    var userSender = await getUser(_auth.currentUser!.email!.split("@")[0]);
    var userReceiver = await getUser(destinateur);

    var productsSender = await getProducts(userSender.uid);
    var productsReceiver = await getProducts(userReceiver.uid);
    Product? p1 =
        productsSender.firstWhere((element) => element.id == product.id);
    var p2 =
        productsReceiver.where((element) => element.id == product.id).toList();

    await _firestore
        .collection("users")
        .doc(userSender.uid)
        .collection("trans")
        .doc(product.id)
        .update({
      "quantity": p1.quantity - product.quantity,
    });

    if (p2.isEmpty) {
      var docId = uuid.v4().split("-").join("");
      await _firestore
          .collection("users")
          .doc(userReceiver.uid)
          .collection("products")
          .doc(docId)
          .set(
              {...product.toJson(), "id": docId, "createdAt": Timestamp.now()});
    } else {
      await _firestore
          .collection("users")
          .doc(userReceiver.uid)
          .collection("product")
          .doc(product.id)
          .update({
        "quantity": p2[0].quantity + product.quantity,
      });
    }
  }
}
