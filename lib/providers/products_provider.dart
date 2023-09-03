import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../service/backend/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  //send data to api
  // void _submitProduct() {
  //   final newProduct = ProductModel(
  //     id: -1,
  //     // Use a temporary ID here, or modify the API to assign IDs
  //     storeId: 0,
  //     categoryId: 0,
  //     name: nameController!.text,
  //     price: double.parse(priceController!.text),
  //     quantity: int.parse(quantityController!.text),
  //     status: 'active',
  //     imageUrl: '',
  //   );
  // }
  Future<void> fetchAndSetProducts() async {
    try {
      final products = ProductService();
      _products = products as List<ProductModel>;
      notifyListeners();
    } catch (error) {
      // Handle error
      print(error);
    }
  }
}
