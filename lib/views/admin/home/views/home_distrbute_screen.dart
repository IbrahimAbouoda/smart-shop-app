import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter
import '../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../core/utils/constant.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final TextEditingController searchController = TextEditingController();
    final ValueNotifier<List<ProductModel>> filteredProducts = ValueNotifier<List<ProductModel>>([]);
    final Future<List<ProductModel>> products = productService.getProducts();

    void performSearch(String query) {
      // You can use the 'query' to filter the products list
      // and update the UI accordingly.
      // Example: Filter products where the name contains the query.
      products.then((list) {
        final filteredList = list.where((product) => product.name.contains(query)).toList();
        filteredProducts.value = filteredList;
      });
    }

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
          onPressed: () => Navigator.pushNamed(context, "/menuAdmin"),
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("الاسم"), Text("السعر"), Text("الكمية")],
          ),
          Expanded(
            child: ValueListenableBuilder<List<ProductModel>>(
              valueListenable: filteredProducts,
              builder: (context, productList, _) {
                if (productList.isEmpty) {
                  return const Center(child: Text('No products available.'));
                } else {
                  return ListView.builder(
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
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 40),
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
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ButtonAppBar1(
              onTapHome: () => Navigator.pushNamed(context, "/homeAdmin"),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: ConstantStayles.kPrimColor,
            onPressed: () {
              Navigator.pushNamed(context, "/AddProduct1");
            },
            child: const Icon(
              Icons.plus_one_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
