import 'package:dio/dio.dart';

class ApiServiceConfig {
  static ApiServiceConfig? _instance ;
  Dio? _dio;

  Dio? get dio => _dio;

  static ApiServiceConfig? get instance {
    _instance ??= ApiServiceConfig?._internal();

    return _instance;
  }

  Dio createDio() {
    var dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 30), receiveTimeout: Duration(seconds: 30), baseUrl: "baseUrl"));

    return dio;
  }

  ApiServiceConfig._internal() {
    _dio = createDio();
  }
}
