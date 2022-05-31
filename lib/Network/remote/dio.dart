import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://206a-154-178-182-188.eu.ngrok.iou/pload',
        receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response> postData({
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      "Content-Type": "multipart/form-data",
    };
    return await dio.post(
      '',
      data: data,
    );
  }
}