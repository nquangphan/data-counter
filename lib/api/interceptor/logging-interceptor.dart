import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  final String token = '';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print('''
[API]----------------> DioSTART\tonRequest \t${options.method} [${options.uri}] ${options.contentType} ''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "[API]------------------> DioEND\tonResponse \t${response.statusCode} [${response.requestOptions.uri}]   ${response.data.toString()} ");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "[API]--------------------> DioEND\tonError \turl:[${err.requestOptions.uri}] type:${err.type} message: ${err.message}");
    super.onError(err, handler);
  }
}
