import 'package:flutter/material.dart';
import 'package:gaza_shop/models/product_model.dart';

class SearchResultPage extends StatelessWidget {
  final String query;

  const SearchResultPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Implement your search logic here using the 'query' parameter
    // to filter and display the search results.

    // For example, you can create a FutureBuilder to display search results.
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for: $query'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        // Replace 'YourProductModel' with your actual product model class.
        // Implement your search logic here, returning a list of search results.
        // For demonstration purposes, I'm using an empty list.
        future: searchProducts(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          } else {
            // Display your search results using a ListView.builder or any other widget.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                // Build and return your product item widget.
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                      'Price: ${product.price} - Quantity: ${product.quantity}'),
                  // Add any other relevant information or actions for each product.
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    // Implement your search logic here to filter and return search results.
    // For demonstration purposes, I'm using an empty list.
    return [];
  }
}
