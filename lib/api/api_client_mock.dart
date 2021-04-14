import 'package:data_counter/models/data-counter-model.dart';

import 'api_client.dart';

class APIClientMock implements APIClient {

  @override
  Future<DataCounterResponse> getData() {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future<DataCounterResponse> loadMoreData(String param) {
    // TODO: implement loadMoreData
    throw UnimplementedError();
  }
 
}
