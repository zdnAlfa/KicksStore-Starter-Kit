import 'package:dio/dio.dart';

/// Model kegagalan jaringan terstruktur untuk aplikasi
class NetworkFailure {
  final int code;
  final String message;

  const NetworkFailure({
    required this.code,
    required this.message,
  });

  @override
  String toString() => message;
}

/// Centralized Error Handler untuk menangani DioException dan memetakan status code HTTP
class ErrorHandler implements Exception {
  late final NetworkFailure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioError(error);
    } else {
      failure = NetworkFailure(
        code: -8,
        message: 'Terjadi kesalahan sistem: ${error.toString()}',
      );
    }
  }

  NetworkFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          code: -1,
          message: 'Waktu koneksi habis (Timeout). Periksa koneksi internet Anda.',
        );
      case DioExceptionType.cancel:
        return const NetworkFailure(
          code: -2,
          message: 'Permintaan data dibatalkan.',
        );
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          code: -6,
          message: 'Gagal terhubung ke server. Pastikan perangkat terhubung ke internet.',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      default:
        return NetworkFailure(
          code: -8,
          message: 'Gangguan koneksi: ${error.message ?? 'Terjadi kesalahan tidak diketahui'}',
        );
    }
  }

  NetworkFailure _handleBadResponse(DioException error) {
    final code = error.response?.statusCode ?? 500;
    String? message = _extractErrorMessage(error.response?.data);

    if (message == null || message.isEmpty) {
      message = _getFallbackMessage(code);
    }

    return NetworkFailure(code: code, message: message);
  }

  String _getFallbackMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Permintaan data tidak valid (Bad Request).';
      case 401:
        return 'Sesi akses tidak sah atau token kadaluarsa (Unauthorized).';
      case 403:
        return 'Akses ke data ini dilarang (Forbidden).';
      case 404:
        return 'Data produk tidak ditemukan di server (404 Not Found).';
      case 422:
        return 'Data yang dikirimkan tidak sesuai format validasi.';
      case 500:
      default:
        return 'Terjadi kendala pada server internal ($statusCode).';
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map) {
      final String? message = data['message']?.toString();
      if (message != null && message.isNotEmpty) {
        return message;
      }
    }
    return null;
  }
}