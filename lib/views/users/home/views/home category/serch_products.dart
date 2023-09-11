import 'package:flutter/material.dart';
import 'package:gaza_shop/models/product_model.dart';
import 'package:gaza_shop/service/backend/product_service.dart';

class ProductsNameSearchDelegate extends SearchDelegate<List<ProductModel>> {
  final ProductService productService = ProductService();

  @override
  String get searchFieldLabel => 'ابحث عن اسم الصنف';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: productService.searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available.'));
        } else {
          final results = snapshot.data;
          return ListView.builder(
            itemCount: results!.length,
            itemBuilder: (context, index) {
              final product = results[index];
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  close(context, [product]); // Return the selected product
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: productService.searchProducts(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available.'));
        } else {
          final suggestionList = snapshot.data;
          return ListView.builder(
            itemCount: suggestionList!.length,
            itemBuilder: (context, index) {
              final product = suggestionList[index];
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  query = product.name;
                  showResults(context);
                },
              );
            },
          );
        }
      },
    );
  }
}
