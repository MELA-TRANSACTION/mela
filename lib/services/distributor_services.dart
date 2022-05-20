import 'package:mela/models/distributor.dart';
import 'package:mela_service/mela_service.dart';

class DistributorApi {
  Future<List<Distributor>> getDist() async {
    var result = await getDistributors();

    if (result.hasException) {
      print(result.exception!.graphqlErrors);
    }

    var data = result.data!['myTrans'] as List;

    return data.map((e) => Distributor.fromJson(e)).toList();
  }
}
