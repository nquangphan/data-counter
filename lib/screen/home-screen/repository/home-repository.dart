import 'package:collection/collection.dart';
import 'package:data_counter/config.dart';
import 'package:data_counter/models/data-by-year-model.dart';
import 'package:data_counter/models/data-counter-model.dart';
import 'package:data_counter/utils/logger.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeRepository {
  DataCounterResponse? data;
  List<Record> recordsQuarter = [];

  List<DataByYear> dataByYear = [];

  Future<dynamic> getData() async {
    recordsQuarter = [];
    return appApiService.client.getData();
  }

  Future<dynamic> loadMoreData() async {
    return appApiService.client.loadMoreData(data?.result?.links?.next ?? '');
  }

  bool isLoadAllData() {
    return recordsQuarter.length == (data?.result?.total ?? -1);
  }

  void caculateDataByYear() {
    dataByYear = [];
    var _dataByYear = groupBy(recordsQuarter, (Record element) {
      return element.quarter!.substring(0, 4);
    });
    _dataByYear.forEach((key, value) {
      double totalData = 0;
      bool isDecrement = false;
      for (int i = 0; i < value.length; i++) {
        totalData += value[i].volumeOfMobileData;
        if (i > 0 &&
            value[i].volumeOfMobileData < value[i - 1].volumeOfMobileData) {
          isDecrement = true;
        }
      }
      dataByYear.add(DataByYear(key, totalData, isDecrement, value));
    });
    printLog(_dataByYear.toString());
  }
}
