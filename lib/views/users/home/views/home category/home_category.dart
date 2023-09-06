import 'package:flutter/material.dart';
import 'package:gaza_shop/components/widgets/general_widgets/buttonApp.dart';
import 'package:gaza_shop/views/users/home/views/home%20category/widgets/new_list_category.dart';
import '../../../../../models/product_model.dart';
import '../../../../../service/backend/product_service.dart';
import 'widgets/choos_part.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final Future<List<ProductModel>> products = productService.getProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('الاقسام الرئيسية'),
      ),
      body: Column(
        children: [
          ChoesGeneralPart(


          ),
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
                      crossAxisCount: 2, // Adjust the number of columns as needed
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8, // Adjust the aspect ratio as needed
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
                          quantity: product.quantity, material: product.productMaterial,);
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, "/details_product",arguments: dataProduct),
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
          ButtonAppBar1(onTapHome: ()=>Navigator.pushNamed(context, "/homeUser"),)
        ],
      ),
    );
  }
}
