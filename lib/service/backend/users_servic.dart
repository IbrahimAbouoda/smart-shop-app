import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';

class UserService {
  final String baseUrl = 'https://shop-smart.phoniexcode.com/api/users';

  Future<List<UsersModel>> getUsers(String type) async {
    final response = await http.get(
      Uri.parse('$baseUrl?type_account=$type'),
      headers: {
        'Authorization': 'Bearer 5|sfOAGFn80PPwPhrM1pXS6ZugJsciwwladyDVytLJ'
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['data'];

      List<UsersModel> users = [];
      for (var userJson in data) {
        users.add(UsersModel.fromJson(userJson));
      }

      return users;
    } else {
      throw Exception(
          'Failed to get users. Status code: ${response.statusCode}');
    }
  }


  Future<void> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Authorization': 'Bearer 5|sfOAGFn80PPwPhrM1pXS6ZugJsciwwladyDVytLJ'
      },
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to delete user. Status code: ${response.statusCode}');
    }
  }

  Future<void> addUser(UsersModel user) async {
    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Authorization': 'Bearer 5|sfOAGFn80PPwPhrM1pXS6ZugJsciwwladyDVytLJ',
        'Content-Type': 'application/json',
      },
    );
  }
}
