import 'dart:developer';
import 'package:dio/dio.dart';
import '../services/local_storage.dart';
import '../network/endpoints.dart';

class DioInterceptor extends Interceptor {
  final LocalStorageService _storage;

  DioInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _storage.get<String>(EndPoints.accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    log('➡️ [REQUEST] ${options.method} ${options.uri}');
    log('Headers: ${options.headers}');
    log('Data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ [RESPONSE] ${response.statusCode} -> ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('❌ [ERROR] ${err.response?.statusCode} -> ${err.message}');

    if (err.response?.statusCode == 401) {
      await _storage.remove(EndPoints.accessTokenKey);
      log('⚠️ Token expired, forcing logout...');
      // هنا ممكن تضيف Navigator أو أي طريقة لإعادة التوجيه للـ login
    }

    handler.next(err);
  }
}
