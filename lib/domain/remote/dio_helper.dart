import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:task_manager_app/ui/helpers/app_constants.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrlIP,
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String lang = "ar",
  }) async {
    var response = await dio!.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token", "lang": lang},
        // headers: {'auth-token': token},
      ),
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    var response = await dio!.post(
      url,
      queryParameters: query,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: body,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    var response = await dio!.put(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    var response = await dio!.delete(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }
}
