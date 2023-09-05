import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/category_model.dart';

class CategoryService {
  final String apiUrl = "https://shop-smart.phoniexcode.com/api/categories"; // Replace with your API URL

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<CategoryModel> categories = [];
        for (var item in jsonData['data']) {
          categories.add(CategoryModel(
            id: item['id'],
            parentId: item['parent_id'],
            name: item['name'],
            slug: item['slug'],
            status: item['status'],
            notes: item['notes'],
            imageUrl: item['image_url'],

          ));
        }
        return categories;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> postCategory(CategoryModel category, String token) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(category),
      );
      if (response.statusCode == 201) {
        // ignore: avoid_print
        print('Category posted successfully');
      } else {
        throw Exception("Failed to post category");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
