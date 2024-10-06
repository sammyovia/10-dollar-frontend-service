import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkService {
  late Dio _dio;
  final Ref ref;
  final TokenStorage _tokenStorage = TokenStorage();

  NetworkService({required this.ref}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://one0-dollar-backend-service.onrender.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      ),
    );

    _dio.interceptors.add(_AuthInterceptor(tokenStorage: _tokenStorage));
    _dio.interceptors.add(
        _ErrorInterceptor(ref: ref, tokenStorage: _tokenStorage, dio: _dio));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Connection timed out');
        case DioExceptionType.badResponse:
          return ServerException(' ${error.response?.data['message']}');
        case DioExceptionType.cancel:
          return RequestCancelledException('Request was cancelled');
        default:
          return error;
      }
    }
    return UnknownException('An unknown error occurred');
  }
}

class _AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;

  _AuthInterceptor({required this.tokenStorage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenStorage.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }
    return handler.next(options); // Continue with the request
  }
}

class _ErrorInterceptor extends Interceptor {
  final Ref ref;
  final TokenStorage tokenStorage;
  final Dio dio;

  _ErrorInterceptor(
      {required this.ref, required this.tokenStorage, required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final isRefreshed = await _attemptTokenRefresh();
      if (isRefreshed) {
        // Retry the request with the new token
        final response = await _retryRequest(err.requestOptions);
        return handler.resolve(response);
      } else {
        // Clear tokens and navigate to login
        await tokenStorage.clearTokens();
        ref.read(router).go(AppRoutes.login);
      }
    }

    handler.next(err);
  }

  Future<bool> _attemptTokenRefresh() async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        final refreshToken = await tokenStorage.getRefreshToken();
        log("refresh token from error $refreshToken");
        if (refreshToken == null) return false;

        final response = await Dio().get(
            'https://one0-dollar-backend-service.onrender.com/auth/refresh',
            options: Options(
              headers: {
                "Authorization": "Bearer $refreshToken",
              },
            ));

        final newAccessToken = response.data['data']['accessToken'];
        final newRefreshToken = response.data['data']['refreshToken'];

        await tokenStorage.saveTokens(
            accessToken: newAccessToken, refreshToken: newRefreshToken);

        return true;
      } catch (e) {
        log('Token refresh failed: $e');
        retryCount++;
        await Future.delayed(
          Duration(seconds: math.pow(2, retryCount).toInt()),
        ); // Exponential backoff
      }
    }
    return false;
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final newAccessToken = await tokenStorage.getAccessToken();

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        "Authorization": "Bearer $newAccessToken",
      },
    );

    final response = dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );

    return response;
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  @override
  String toString() {
    return message;
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  @override
  String toString() {
    return message;
  }
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
@override
  String toString() {
    return message;
  }
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
  @override
  String toString() {
    return message;
  }
}
