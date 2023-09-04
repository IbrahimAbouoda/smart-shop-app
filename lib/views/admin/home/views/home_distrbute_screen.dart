// search_product_page.dart

import 'package:flutter/material.dart';
import '../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../core/utils/constant.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  // final productService = ProductService();
  // late Future<List<ProductModel>> products;
  // final TextEditingController searchController = TextEditingController();

  List<ProductModel> products =
      []; // Populate this list with data from ProductService
  ProductService productService = ProductService();
  @override
  void initState() {
    super.initState();
    // Fetch products when the widget is initialized
    productService.getProducts().then((productList) {
      setState(() {
        products = productList;
      });
    });
  }

  // void performSearch(String query) {
  //   // You can use the 'query' to filter the products list
  //   // and update the UI accordingly.
  //   // Example: Filter products where the name contains the query.
  //   products.then((list) {
  //     final filteredList = list.where((product) => product.name.contains(query)).toList();
  //     setState(() {
  //       // Update the product list with filtered results
  //       productList = filteredList;
  //     });
  //   });
  // }

  List<ProductModel> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarUserPages(
          hintText: "ابحث عن اسم المنتج",
          // controller: searchController,
          // onChange: (value) {
          //   // Trigger search when the text changes
          //   performSearch(value);
          // },
          onPressed: () {
            // You can add any additional actions when the search button is pressed
          },
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("الاسم"), Text("السعر"), Text("الكمية")],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle:
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                  leading: Image.network(product.imageUrl),
                  // Add more widgets to display other product information
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
