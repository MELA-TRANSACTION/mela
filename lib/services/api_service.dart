import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mela/models/distributor.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getDistributor(String phone) async {
    var results = await _firestore
        .collection("distributors")
        .where({"phone": phone}).get();
    return results.docs[0].id;
  }

  Stream<List<Distributor>> getDistributors() {
    return _firestore
        .collection("distributors")
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Distributor.fromJson(e.data()),
            )
            .toList());
  }

  Future<String> getDestinateur(String phone) async {
    var results =
        await _firestore.collection("users").where({"phone": phone}).get();
    return results.docs[0].id;
  }
}
