import 'package:dio/dio.dart';
import 'package:ElevatED/core/constants/api_constants.dart';

class DioManager {
  DioManager._();

  static Future<Dio> getDio() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      receiveDataWhenStatusError: true,
      receiveTimeout: ApiConstants.apiTimeOut,
      sendTimeout: ApiConstants.apiTimeOut,
      validateStatus: (status) => true,
    );

    return dio;
  }
}
