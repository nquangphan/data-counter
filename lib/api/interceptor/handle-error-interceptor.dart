import 'package:data_counter/config.dart';
import 'package:data_counter/utils/logger.dart';
import 'package:dio/dio.dart';

class HandleErrorInterceptor extends Interceptor {
  final Dio dio;

  HandleErrorInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handlError(err);
  }

  Future<dynamic> handlError(DioError error) async {
    switch (error.type) {
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
        printLog('Time out');
        break;
      case DioErrorType.response:
        {
          printLog(
              "[AppApiService] _handleError DioErrorType.RESPONSE status code: ${error.response!.statusCode}");
          printLog(error.message);
          var statusCode = error.response?.statusCode ?? -1;
          if (statusCode == 401) {
            //call refresh token and retry here
            _lockDio();
            var isRefrehed = await refreshToken();
            _unlockDio();
            if (isRefrehed) {
              return _retry(error.response!.requestOptions);
            }
          }
          if (statusCode == 403) {
            // refresh toke
          } else if (statusCode >= 500 && statusCode < 600) {
          } else {
            // result.message = getErrorMessage(error.response.data);
          }
          break;
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        //  Url not Server die or No Internet connection
        printLog(
            "[AppApiService] _handleError DioErrorType.DEFAULT status code: error.response is null -> Server die or No Internet connection");

        break;
    }
    return error;
  }

  void _lockDio() {
    dio.lock();
// _dio.interceptors.requestLock.lock();
    dio.interceptors.responseLock.lock();
    dio.interceptors.errorLock.lock();
  }

  void _unlockDio() {
    dio.unlock();
// _dio.interceptors.requestLock.unlock();
    dio.interceptors.responseLock.unlock();
    dio.interceptors.errorLock.unlock();
  }

  String? getErrorMessage(Map<String, dynamic> dataRes) {
    if (dataRes.containsKey("message") && dataRes["message"] != null) {
      return dataRes["message"]?.toString();
    }
    if (dataRes.containsKey("error") && dataRes["error"] != null) {
      return dataRes["error"]?.toString();
    }
    return dataRes.toString();
  }

  Future<bool> refreshToken() async {
    Dio _dio = Dio(BaseOptions(baseUrl: appBaseUrl));
    final refreshToken = sharedPreferences!.getString('refresh_token');
    final response =
        await _dio.post('/refreshToken', data: {'token': refreshToken});

    if (response.statusCode == 200) {
      sharedPreferences!
          .setString('access_token', response.data['accessToken']);
      appApiService.setOAuthToken(response.data['accessToken']);
      return true;
    }
    return false;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
