import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hero/core/api/status_code.dart';

import '../error/exceptions.dart';
import 'app_interceptors.dart';
import 'base_api_consumer.dart';
import 'end_points.dart';
import 'package:hero/injector.dart' as injector;

class DioConsumer implements BaseApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..receiveTimeout = 1000 * 80
      ..connectTimeout = 1000 * 80
      ..sendTimeout = 1000 * 80
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(injector.serviceLocator<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(injector.serviceLocator<LogInterceptor>());
    }
  }
  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await client.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data);
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unautherized:
            throw const UnauthorizedException();
          case StatusCode.forbidden:
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }

  @override
  Future newPost(String path,
      {bool formDataIsEnabled = false,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await client.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future delete(String path,
      {bool formDataIsEnabled = false,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await client.delete(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }
}
