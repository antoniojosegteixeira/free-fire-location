import 'dart:developer';

import 'package:dio/dio.dart';

enum RequestMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension RequestMethodString on RequestMethod {
  String get stringName {
    switch (this) {
      case RequestMethod.get:
        return 'get';
      case RequestMethod.post:
        return 'post';
      case RequestMethod.patch:
        return 'patch';
      case RequestMethod.put:
        return 'put';
      case RequestMethod.delete:
        return 'delete';
    }
  }
}

class HttpRequest {
  HttpRequest({required this.dio});

  final Dio dio;

  Future<Response> doRequest({
    required String endpoint,
    required RequestMethod requestMethod,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.request(
        endpoint,
        data: body,
        options: Options(
          method: requestMethod.stringName,
          followRedirects: false,
          validateStatus: (int? status) {
            return true;
          },
          headers: headers,
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
