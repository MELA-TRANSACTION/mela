import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mela/models/product.dart';
import 'package:mela/models/trans.dart';

class TransService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Trans>> getTrans() {
    String uid = _auth.currentUser!.uid;

    return _firestore
        .collection("transactions")
        .where("distributor.uid", isEqualTo: uid)
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

  Future addTrans(var data) async {
    await _firestore.collection("transactions").add(data);

    final productsClient = await _firestore
        .collection("users")
        .doc(data.client.uid)
        .collection("products")
        .get();

    List<Product> prodClients =
        productsClient.docs.map((e) => Product.fromJson(e.data())).toList();

    for (int i = 0; i < prodClients.length; i++) {
      if (prodClients[i].id == data.products[i]['id']) {
        await _firestore
            .collection("users")
            .doc(data.client.uid)
            .collection("products")
            .doc(prodClients[i].id)
            .update({
          "quantity": prodClients[i].quantity + data.products[i]['quantity'],
        });
      } else {
        await _firestore
            .collection("users")
            .doc(data.distributor.uid)
            .collection("products")
            .add(data.products[i]);
      }
    }

    final productsDistributor = await _firestore
        .collection("users")
        .doc(data.client.uid)
        .collection("products")
        .get();

    List<Product> prodDistr = productsDistributor.docs
        .map((e) => Product.fromJson(e.data()))
        .toList();

    for (int i = 0; i < prodClients.length; i++) {
      if (prodDistr[i].id == data.products[i]['id']) {
        await _firestore
            .collection("users")
            .doc(data.distributor.uid)
            .collection("products")
            .doc(prodClients[i].id)
            .update({
          "quantity": prodClients[i].quantity - data.products[i]['quantity'],
        });
      } else {
        await _firestore
            .collection("users")
            .doc(data.distributor.uid)
            .collection("products")
            .doc(data.products[i]['id'])
            .delete();
      }
    }
  }
}
