import 'package:flutter/foundation.dart';
import 'package:mela/models/trans_mela.dart';
import 'package:mela/services/auth_service.dart';
import 'package:mela_service/mela_service.dart';

class TransService {
  Future<List<Trans>> getTrans() async {
    var user = await AuthService().me();
    if (kDebugMode) {
      print(">>>>>>>>>>>>>>>>>>>>>" + user!.phone);
    }

    var result = await getMyTrans(user!.id);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception!.graphqlErrors);
      }
    }

    print(result);

    var data = result.data!['myTrans'] as List;

    return data.map((e) => Trans.fromJson(e)).toList();
  }

  Future recharge(Map<String, dynamic> data) async {
    var result = await rechargeClient(data);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception!.graphqlErrors);
      }
    }
  }

  Future withdrawFrom(Map<String, dynamic> data) async {
    var result = await withdraw(data);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception!.graphqlErrors);
      }
    }
  }

  Future shareWith(Map<String, dynamic> data) async {
    var result = await shareClient(data);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception!.graphqlErrors);
      }
    }
  }
}
