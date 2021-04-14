import 'package:data_counter/config.dart';
import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_client_mock.dart';
import 'interceptor/oauth-interceptor.dart';

class AppApiService {
  final dio = Dio();
  late APIClient client;

  void create() {
    dio.options.receiveTimeout = 3 * 1000;
    dio.options.sendTimeout = 5 * 1000;
    dio.options.headers["content-type"] = "application/json";

    if (buildFlavor == BuildFlavor.mockDataOffline) {
      client = APIClientMock();
    } else {
      client = APIClient(dio, baseUrl: appBaseUrl);
    }
  }

  void setOAuthToken(String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor)
              as OAuthInterceptor)
          .token = token;
    }
  }
}
