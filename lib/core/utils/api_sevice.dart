import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServise {
  final Dio _dio;
  final String baseUrl = "https://www.googleapis.com/books/v1/";

  ApiServise(this._dio);
  Future<SharedPreferences> sh = SharedPreferences.getInstance();

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get("$baseUrl$endPoint");

    return response.data;
  }
}
