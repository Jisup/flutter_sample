import 'package:dio/dio.dart';

class DioInstance {
  static final DioInstance _instance = DioInstance._internal();
  late Dio dio;

  DioInstance._internal() {
    dio = Dio();
    dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    dio.options.headers = {
      'Content-type': 'application/json; charset=UTF-8',
    };
  }

  factory DioInstance() {
    return _instance;
  }
}
