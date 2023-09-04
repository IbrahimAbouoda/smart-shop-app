import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../models/product_model.dart';

class ProductService extends ChangeNotifier {
  static var productUrl = 'http://shop-smart.phoniexcode.com/api/products';

  Future<List<ProductModel>> searchProducts(String query) async {
    final url = Uri.parse('http://shop-smart.phoniexcode.com/api/products'); // Replace with your API endpoint

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<ProductModel> products = []; // Create a list to store products

        // Parse the response JSON and filter products based on the query
        // Example: Filter products where the name or price contains the query
        final parsedData = json.decode(response.body);
        for (var item in parsedData) {
          final product = ProductModel.fromJson(item); // Deserialize product data
          if (product.name.contains(query) || product.price.toString().contains(query)) {
            products.add(product);
          }
        }

        return products; // Return the filtered list of products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  Future<List<ProductModel>> getProducts() async {
    try {
      final http.Response response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<ProductModel> products = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        notifyListeners();
        return products;
      } else if (response.statusCode == 404) {
        throw Exception('Failed to load products');
      } else if (response.statusCode == 500) {
        throw Exception('Server not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request.
      return Future.error(e); // You can return an error message or handle it as needed.
    }
  }
  Future<List<ProductModel>> getProductsTrending() async {
    try {
      final http.Response response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<ProductModel> products = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        notifyListeners();
        return products;
      } else if (response.statusCode == 404) {
        throw Exception('Failed to load products');
      } else if (response.statusCode == 500) {
        throw Exception('Server not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request.
      return Future.error(e); // You can return an error message or handle it as needed.
    }
  }

  Future<void> postProduct(ProductModel product) async {
    final Map<String, dynamic> productData = {
      'name': product.name,
      'price': product.price,
      'size': product.size,
      'status': product.status,
      'type': product.type,
      'notes': product.notes,
      'quantity': product.quantity,
      'manufacturer_company': product.manufacturerCompany,
      'image_url': product.imageUrl,
      // Include other product properties here
    };

    final response = await http.post(
      Uri.parse(productUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(productData),
    );

    if (response.statusCode == 201) {
      print('Product posted successfully');
    } else {
      print('Failed to post product. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(Uri.parse('$productUrl/$productId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
    notifyListeners();
  }





  // Method to create a new product
  //  Future<void> postProduct(ProductModel product) async {
//     final Map<String, dynamic> productData = {
//       'name': product.name,
//       'price': product.price,
//       'size': product.size,
//       'status': product.status,
//       'type': product.type,
//       'notes': product.notes,
//       'quantity': product.quantity,
//       'manufacturer_company': product.manufacturerCompany,
//       'image_url': product.imageUrl,
//       // Include other product properties here
//     };

  // Method to delete a product by ID
  // static Future<void> deleteProduct(int productId) async {
  //   final response = await http.delete(Uri.parse('$baseUrl/$productId'));

  //   if (response.statusCode != 204) {
  //     throw Exception('Failed to delete product');
  //   }
  // }
}
