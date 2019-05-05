import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

const String HOST = "https://jsonplaceholder.typicode.com";

class Network {
  static Network get network => _get();
  static Network _network;

  Dio _dio = new Dio();

  factory Network() => _get();

  Network._internal() {
    // 初始化dio
    _dio.options.baseUrl = HOST;
    _dio.transformer = FlutterTransformer();
    _dio.interceptors.add(AuthInterceptor()); // 添加授权（签名、附加参数等处理）拦截器
    _dio.interceptors.add(LogInterceptor(
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false)); // 添加日志拦截器
  }

  static Network _get() {
    if (_network == null) {
      _network = Network._internal();
    }
    return _network;
  }

  Dio dio() => _dio;
}

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    String baseUrl = options.baseUrl;
    dynamic data = options.data;
    Map<String, dynamic> extra = options.extra;
    // 修改参数，添加签名
    Map<String, dynamic> parameters = options.queryParameters;
    String method = options.method;
    print(
        "baseUrl = $baseUrl \n data = $data \n extra = ${extra.toString()} \n parameters = ${parameters.toString()} \n method = $method");
    return super.onRequest(options);
  }
}

void main() {
  Future<Response<String>> future = Network.network
      .dio()
      .get("http://www.baidu.com", queryParameters: {"key1": 123, "key2": 456});
  future.catchError((error) {
    print("error = $error");
  }).then((response) {
    print("response = 成功");
  }).whenComplete(() {
    print("完成");
  });
}

class RequestException extends IOException {
  final int code;
  final String message;
  final dynamic error;
  RequestException({this.code, this.message, this.error});
}

class SimpleRequestException extends RequestException {
  static final SimpleRequestException _singlon =
      SimpleRequestException._internal();

  @override
  int get code => -1;
  @override
  String get message => "加载失败，请稍候重试";

  SimpleRequestException._internal();

  factory SimpleRequestException() {
    return _singlon;
  }
}
