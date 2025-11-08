import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../services/local_storage.dart';
import '../network/dio_interceptor.dart';
import '../../config/flavors.dart';

class ApiClient {
  late final Dio _dio;
  final _storage = LocalStorageService();

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppFlavor.baseUrl,
        // baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    // 🔹 ربط DioInterceptor الخاص بيك
    _dio.interceptors.add(DioInterceptor(_storage));

    // 🔹 ربط PrettyDioLogger لعرض كل الطلبات والردود
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }

  Dio get client => _dio;

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      return await _dio.get(endpoint, queryParameters: query);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    final code = e.response?.statusCode;
    final message = e.response?.data ?? e.message;
    log('🚨 API Error [$code]: $message');
  }
}
