import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mela/models/product.dart';

class AccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<Account> getAccountInfo() {
    String uid = _auth.currentUser!.uid;
    return _firestore.collection("accounts").doc(uid).snapshots().map(
          (event) => Account.fromJson(event.data()),
        );
  }

  void initAccount() async {
    String uid = _auth.currentUser!.uid;
    await _firestore.collection("accounts").doc(uid).set({"balance": 0});
  }

  Stream<List<Product>> getBalance() {
    String uid = _auth.currentUser!.uid;

    return _firestore
        .collection("products")
        .where("owner.uid", isEqualTo: uid)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Product.fromJson(e.data()),
              )
              .toList(),
        );
  }

  Future<void> shareBeer(List<Product> products, String destinateur) async {
    String uid = _auth.currentUser!.uid;

    for (var p in products) {
      await _firestore.collection("products").doc(p.id).delete();
    }
  }

  Future<void> withDrawBeer(List<Product> products, String destinateur) async {
    String uid = _auth.currentUser!.uid;

    for (var p in products) {
      await _firestore.collection("products").doc(p.id).delete();
    }
  }
}
