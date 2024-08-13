import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/urls/app_urls.dart';

class DioService {
  DioService() {
    _dio = Dio(_createBaseOptions());
    _addInterceptors();
  }

  late final Dio _dio;

  Dio get dio => _dio;

  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: AppUrls.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
  }

  Future<String?> _getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString("token");
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token != null) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          }
          return handler.next(options); // continue with the request
        },
        onResponse: (response, handler) {
          // You can add global response handling here if needed
          return handler.next(response);
        },
        onError: (error, handler) {
          // You can add global error handling here if needed
          return handler.next(error);
        },
      ),
    );
  }
}
