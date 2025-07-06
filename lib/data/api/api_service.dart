// lib/data/api/api_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://fcihub.onrender.com/';

  ApiService() : _dio = Dio(BaseOptions(baseUrl: _baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // قائمة بنقاط النهاية التي لا تتطلب رمز مصادقة (فقط نقاط تسجيل الدخول/التسجيل/إعادة تعيين كلمة المرور)
        const List<String> publicEndpoints = [
          'auth/login-user', //
          'auth/login-admin', //
          'auth/register-user', //
          'auth/register-admin', //
          'auth/forgot-password', //
          'auth/verify-reset-code', //
          'auth/reset-password', //
        ];

        // التحقق مما إذا كان المسار الحالي ضمن نقاط النهاية العامة (لا تتطلب مصادقة)
        final isPublicEndpoint = publicEndpoints.any((endpoint) => options.path.contains(endpoint));

        // إذا لم يكن الطلب إلى نقطة نهاية عامة (أي يتطلب مصادقة)، أضف رمز المصادقة
        if (!isPublicEndpoint) {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            log('Request: Token added for ${options.uri}');
          } else {
            // هذا يحدث إذا كان الطلب يتطلب مصادقة ولكن لا يوجد رمز مصادقة مخزن
            log('Request: No token found for authenticated endpoint: ${options.uri}');
          }
        } else {
          log('Request: Public endpoint, no token required: ${options.uri}');
        }

        log('Request: ${options.method} ${options.uri}');
        log('Headers: ${options.headers}');
        log('Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('Response Status: ${response.statusCode}');
        log('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        log('Error Type: ${e.type}');
        log('Error Message: ${e.message}');
        log('Error Response Status: ${e.response?.statusCode}');
        log('Error Response Data: ${e.response?.data}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return UnauthorizedException('Unauthorized: Token might be invalid or expired.');
      }
      return ApiException(e.response!.statusCode!, e.response!.data.toString());
    } else {
      return NetworkException('Network Error: Please check your internet connection.');
    }
  }
}

// Custom Exceptions ( unchanged )
class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() => 'ApiException: Status Code $statusCode, Message: $message';
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
  @override
  String toString() => 'NetworkException: $message';
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  @override
  String toString() => 'UnauthorizedException: $message';
}