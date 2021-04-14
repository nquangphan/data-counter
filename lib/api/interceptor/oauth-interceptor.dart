import 'package:dio/dio.dart';

class OAuthInterceptor extends Interceptor {
  String token = '';
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (token.isNotEmpty == true) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
