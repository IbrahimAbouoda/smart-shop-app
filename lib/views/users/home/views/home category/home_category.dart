import 'package:flutter/material.dart';
import 'package:gaza_shop/components/widgets/general_widgets/buttonApp.dart';
import 'package:gaza_shop/service/backend/categories.dart';
import 'package:gaza_shop/views/users/home/views/home%20category/serch_category.dart';
import 'package:gaza_shop/views/users/home/views/home%20category/widgets/new_list_category.dart';
import '../../../../../models/category_model.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/stores_model.dart';
import '../../../../../service/backend/product_service.dart';
import '../../../../../service/backend/store_servic.dart';
import '../home user/serch_store.dart';
import 'widgets/choos_part.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final Future<List<ProductModel>> products = productService.getProducts();

    void _startSearch(BuildContext context) async {
      final categoryService = CategoryService();
      final List<CategoryModel> categories = await categoryService.getCategories();

      showSearch(
        context: context,
        delegate: CategoryNameSearchDelegate(categories),
      ).then((selectedCategory) {
        if (selectedCategory != null) {
          // Handle the selected category (e.g., filter products by category)
          print('Selected category: ${selectedCategory.name}');
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('الاقسام الرئيسية'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _startSearch(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ChoesGeneralPart(),
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products available.'));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      ProductModelDetails dataProduct = ProductModelDetails(
                        id: product.id,
                        name: product.name,
                        note: product.notes,
                        price: product.price,
                        imageUrl: product.imageUrl,
                        quantity: product.quantity,
                        material: product.productMaterial,
                      );
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/details_product",
                          arguments: dataProduct,
                        ),
                        child: NewListCategoris(
                          image: product.imageUrl,
                          title: "الترند",
                          comparePrice: product.comparePrice.toString(),
                          name: product.name,
                          price: product.price.toString(),
                          quantity: product.quantity.toString(),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ButtonAppBar1(onTapHome: () => Navigator.pushNamed(context, "/homeUser")),
        ],
      ),
    );
  }
}
