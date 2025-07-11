// lib/data/api/api_service.dart
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:io';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://fcihub.onrender.com/';

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        )) {
    // Configure SSL/TLS settings for HTTPS connections
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // For development/testing purposes - accept all certificates
        // In production, you should implement proper certificate validation
        return true;
      };
      return client;
    };

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
        final isPublicEndpoint =
            publicEndpoints.any((endpoint) => options.path.contains(endpoint));

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

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await _executeWithRetry(() async {
      return await _dio.get(path, queryParameters: queryParameters);
    });
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _executeWithRetry(() async {
      return await _dio.post(path, data: data);
    });
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _executeWithRetry(() async {
      return await _dio.put(path, data: data);
    });
  }

  Future<Response> delete(String path) async {
    return await _executeWithRetry(() async {
      return await _dio.delete(path);
    });
  }

  // Test connection method
  Future<bool> testConnection() async {
    try {
      final response = await _dio.get('/health',
          options: Options(
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ));
      return response.statusCode == 200;
    } catch (e) {
      log('Connection test failed: $e');
      return false;
    }
  }

  // Retry mechanism for handling SSL/TLS and connection issues
  Future<Response> _executeWithRetry(Future<Response> Function() request,
      {int maxRetries = 3}) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        return await request();
      } on DioException catch (e) {
        attempts++;
        log('Request attempt $attempts failed: ${e.type} - ${e.message}');

        // Check if it's a handshake or SSL error and we haven't exceeded max retries
        if (attempts < maxRetries &&
            (e.error.toString().contains('HandshakeException') ||
                e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout)) {
          // Wait before retrying (exponential backoff)
          await Future.delayed(Duration(seconds: attempts * 2));
          log('Retrying request... (attempt ${attempts + 1}/$maxRetries)');
          continue;
        }

        // If max retries reached or it's not a retryable error, throw the handled error
        throw _handleDioError(e);
      }
    }

    // This should never be reached, but just in case
    throw NetworkException('Max retries exceeded');
  }

  Exception _handleDioError(DioException e) {
    log('DioException Type: ${e.type}');
    log('DioException Message: ${e.message}');
    log('DioException Error: ${e.error}');

    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return UnauthorizedException(
            'Unauthorized: Token might be invalid or expired.');
      }
      return ApiException(e.response!.statusCode!, e.response!.data.toString());
    } else {
      // Handle different types of connection errors
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return NetworkException('Connection timeout. Please try again.');
        case DioExceptionType.sendTimeout:
          return NetworkException('Send timeout. Please try again.');
        case DioExceptionType.receiveTimeout:
          return NetworkException('Receive timeout. Please try again.');
        case DioExceptionType.connectionError:
          if (e.error.toString().contains('HandshakeException')) {
            return NetworkException(
                'SSL/TLS connection error. Please check your internet connection or try again later.');
          }
          return NetworkException(
              'Connection error. Please check your internet connection.');
        case DioExceptionType.unknown:
          if (e.error.toString().contains('HandshakeException')) {
            return NetworkException(
                'SSL/TLS handshake failed. Please check your internet connection or try again later.');
          }
          return NetworkException(
              'Network error. Please check your internet connection.');
        default:
          return NetworkException(
              'Network Error: Please check your internet connection.');
      }
    }
  }
}

// Custom Exceptions ( unchanged )
class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() =>
      'ApiException: Status Code $statusCode, Message: $message';
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
