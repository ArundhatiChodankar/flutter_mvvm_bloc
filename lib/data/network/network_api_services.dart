import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app_exceptions.dart';
import 'base_api_services.dart';
import 'dio_services.dart';

class NetworkApiServices extends BaseApiServices {
  final _dio = DioService().dio;

  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response = await _dio.get(url);
      jsonResponse = returnJsonResponse(response);
    }  on SocketException  {
      throw InternetException("No Internet");
    }  on TimeoutException  {
      throw TimeoutException("Time Out");
    } on DioException  {
      throw InternetException("No Internet");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    if (kDebugMode) {
      print('$data');
    }
    dynamic jsonResponse;
    try {

      final response = await _dio.post(url, data: data);

      jsonResponse = returnJsonResponse(response);
    }  on SocketException  {
      throw InternetException("No Internet");
    }  on TimeoutException  {
      throw TimeoutException("Time Out");
    } on DioException  {
      throw InternetException("No Internet");
    }
    return jsonResponse;
  }
}

dynamic returnJsonResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 400:
      throw response.data;
    case 401:
      throw UnauthorizedException(response.data);
    default:
      throw InternetException(
          'Error occurred while communicating with server with status code${response.statusCode}');
  }
}
