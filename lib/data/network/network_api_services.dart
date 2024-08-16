import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app_exceptions.dart';
import 'base_api_services.dart';
import 'dio_services.dart';

class NetworkApiServices extends BaseApiServices {
  final Dio _dio = DioService().dio;

  @override
  Future<dynamic> getGetApiResponse(String url) async {
    try {
      final response = await _dio.get(url);
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    if (kDebugMode) {
      print('Request data: $data');
    }

    try {
      final response = await _dio.post(url, data: data);
      if (kDebugMode) {
        print('Response: $response');
      }
      return _handleResponse(response);
    } on SocketException {
      throw InternetException("No Internet connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  dynamic _handleResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data);
      case 401:
        throw UnauthorizedException(response.data);
      default:
        throw InternetException(
          'Error occurred while communicating with server with status code ${response.statusCode}',
        );
    }
  }

  dynamic _handleDioError(DioException e) {
    if (e.response != null) {
      // Handle specific status codes if necessary
      switch (e.response?.statusCode) {
        case 400:
          return e.response?.data;
        case 401:
          throw UnauthorizedException(e.response?.data);
      // Add more cases if needed
        default:
          throw InternetException(
            'Error occurred while communicating with server with status code ${e.response?.statusCode}',
          );
      }
    } else {
      // Handle errors without response (e.g., network issues)
      throw InternetException('An unknown error occurred');
    }
  }
}
