import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dio_exception.dart';

/// HTTP Client Wrapper terpusat yang membungkus instance Dio (mengadopsi arsitektur mobodrive)
class DioClient {
  final Dio _dio;

  DioClient([Dio? dio]) : _dio = dio ?? Dio() {
    _configureOptions();
    _configureInterceptors();
  }

  /// Konfigurasi default base options, timeout, dan headers
  void _configureOptions() {
    _dio.options
      ..baseUrl = 'https://dummyjson.com'
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..sendTimeout = const Duration(seconds: 15)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }

  /// Konfigurasi interceptor untuk pengamatan request & respons di console terminal
  void _configureInterceptors() {
    _dio.interceptors.clear();

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: false,
          error: true,
          logPrint: (obj) => debugPrint('[DIO CLIENT] $obj'),
        ),
      );
    }
  }

  /// Getter instance Dio jika dibutuhkan konfigurasi spesifik tingkat lanjut
  Dio get rawDio => _dio;

  /// Centralized request execution wrapper untuk menangkap DioException secara terpusat
  Future<Response<T>> _request<T>(
    Future<Response<T>> Function() requestCall,
  ) async {
    try {
      return await requestCall();
    } catch (e) {
      throw ErrorHandler.handle(e).failure;
    }
  }

  /// HTTP GET Request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP POST Request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP PUT Request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP DELETE Request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }
}