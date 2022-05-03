import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mela/models/product.dart';

class ProductService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Product>> getProducts() {
    String uid = _auth.currentUser!.uid;
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("products")
        //.orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Product.fromJson(e.data()),
              )
              .toList(),
        );
  }
}
