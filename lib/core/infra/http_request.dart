import 'package:dio/dio.dart';

enum RequestMethod {
  get,
  post,
  put,
  patch,
  delete,
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
      final response = await dio.request<Map>(
        endpoint,
        data: body,
        options: Options(
          method: requestMethod.toString(),
          followRedirects: false,
          validateStatus: (int? status) {
            return true;
          },
          headers: headers,
        ),
      );

      return response;
    } catch (e) {
      throw Error();
    }
  }
}
