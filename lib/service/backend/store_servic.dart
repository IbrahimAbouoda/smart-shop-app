
// ignore_for_file: avoid_print

import 'dart:convert';
import '../../models/stores_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
class StoreService {
  final String apiUrl = "https://shop-smart.phoniexcode.com/api/stores";
  bool isPosting = true;



  Future<List<StoreModel>> getStores() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body)['data'];
      return responseData.map((json) => StoreModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }

  Future<void> postStore(StoreModel store, String token) async {
    try {
      // Set the flag to show loading indicator

      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({
          "name": store.name,
          "slug": store.slug,
          "notes": store.notes,
          "status": store.status,
          "image_url": store.imageUrl,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        
        print('Store posted successfully');
      } else {
        throw Exception('Failed to post store');
      }
    } catch (e) {
     
      print('Error posting store: $e');
    } finally {
      isPosting = false; // Reset the flag after request completion
    }
  }

  Future<void> deleteStore(int storeId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$storeId'));

    if (response.statusCode == 200) {
      print('Store deleted successfully');
    } else {
      throw Exception('Failed to delete store');
    }
  }
}