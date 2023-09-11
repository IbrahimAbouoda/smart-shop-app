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
  final productService = ProductService();
  late Future<List<ProductModel>> products;
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    // Fetch products when the widget is initialized
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final fetchedProducts = await productService.getProducts();
    setState(() {
      productList = fetchedProducts;
    });
  }

  void performSearch(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all products
      fetchProducts();
    } else {
      // Filter the products based on the query
      final filteredList = productList
          .where((product) => product.name.contains(query))
          .toList();

      setState(() {
        productList = filteredList;
      });
    }
  }


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
            Navigator.pushNamed(context, "/menuAdmin");
          },
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("الاسم"), Text("السعر"), Text("صورة المنتج")],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(product.name),
                      Text('Price: \$${product.price.toStringAsFixed(2)}'),
                      Image.network(
                        product.imageUrl,
                        height: 100,
                        width: 100,
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
