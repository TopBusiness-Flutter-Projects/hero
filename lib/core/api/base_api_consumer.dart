import 'package:dio/dio.dart';

abstract class BaseApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters,Options? options});

  Future<dynamic> post(String path,
      { bool formDataIsEnabled = false,Map<String, dynamic>? body, Map<String, dynamic>? queryParameters,Options? options});

  Future<dynamic> newPost(String path,
      {bool formDataIsEnabled = false,Map<String, dynamic>? body, Map<String, dynamic>? queryParameters,Options? options});

  Future<dynamic> put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters,Options? options});

  Future<dynamic> delete(String path,
      { bool formDataIsEnabled = false,Map<String, dynamic>? body, Map<String, dynamic>? queryParameters,Options? options});

}
