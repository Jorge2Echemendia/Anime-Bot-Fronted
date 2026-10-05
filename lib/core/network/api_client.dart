import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/env.dart';
import '../storage/secure_storage.dart';
import 'api_exception.dart';
import 'auth_interceptor.dart';

class ApiClient {
  final Dio _dio;
  ApiClient(SecureStorage storage)
      : _dio = Dio(BaseOptions(
          baseUrl: Env.apiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
        )) {
    _dio.interceptors.add(AuthInterceptor(storage));
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    return _request(() => _dio.get(path));
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    return _request(() => _dio.post(path, data: body));
  }

  Future<Map<String, dynamic>> _request(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  ApiException _mapDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NetworkException('No se pudo conectar con el servidor');
    }
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['error'] != null) {
      return ApiException.fromJson(data['error'] as Map<String, dynamic>);
    }
    return ServerException('UNKNOWN', e.message ?? 'Error desconocido');
  }
}