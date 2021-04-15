import 'package:data_counter/models/data-counter-model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

/// https://pub.dev/packages/retrofit
/// flutter pub run build_runner build

@RestApi(baseUrl: "")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  // @POST('/authenticate')
  // Future<LoginResponse> login(@Body() Map<String, dynamic> loginRequest);

  @GET(
      '/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=100')
  Future<DataCounterResponse> getData();

  @GET('{param}')
  Future<DataCounterResponse> loadMoreData(@Path('param') String param);
}
