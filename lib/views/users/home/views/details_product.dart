// search_product_page.dart

import 'package:flutter/material.dart';
import '../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../core/utils/constant.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';

class DetailsProduct extends StatefulWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  final productService = ProductService();
  late Future<List<ProductModel>> products;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the product list when the widget is created
    products = productService.getProducts();
  }

  void performSearch(String query) {
    // You can use the 'query' to filter the products list
    // and update the UI accordingly.
    // Example: Filter products where the name contains the query.
    products.then((list) {
      final filteredList = list.where((product) => product.name.contains(query)).toList();
      setState(() {
        // Update the product list with filtered results
        productList = filteredList;
      });
    });
  }

  List<ProductModel> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarUserPages(
          hintText: "ابحث عن اسم المنتج",
          controller: searchController,
          onChange: (value) {
            // Trigger search when the text changes
            performSearch(value);
          },
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
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xff27374D),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: ConstantStayles.kPrimColor,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: ConstantStayles.style2,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          "[ش] ${product.price}",
                          style: ConstantStayles.style2,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          "${product.quantity}",
                          style: ConstantStayles.style2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
