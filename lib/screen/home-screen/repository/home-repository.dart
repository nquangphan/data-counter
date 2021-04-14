import 'package:data_counter/config.dart';
import 'package:data_counter/models/data-counter-model.dart';

class HomeRepository {
  DataCounterResponse? data;

  Future<dynamic> getData() async {
    return appApiService.client.getData();
  }
}
