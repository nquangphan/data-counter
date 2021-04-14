import 'package:data_counter/config.dart';
import 'package:data_counter/models/data-counter-model.dart';

class HomeRepository {
  DataCounterResponse? data;
  List<Record> records = [];

  Future<dynamic> getData() async {
    records = [];
    return appApiService.client.getData();
  }

  Future<dynamic> loadMoreData() async {
    return appApiService.client.loadMoreData(data?.result?.links?.next ?? '');
  }

  bool isLoadAllData() {
    return records.length == (data?.result?.total ?? -1);
  }
}
