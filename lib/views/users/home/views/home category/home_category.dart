import 'package:flutter/material.dart';
import 'package:gaza_shop/components/widgets/general_widgets/buttonApp.dart';
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
        title: Text('Home Category'),
      ),
      body: Column(
        children: [
          ChoesGeneralPart(
            onTap: () {
              Navigator.pushNamed(context, "/homeCategory");
            },
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

class NewListCategoris extends StatelessWidget {
  const NewListCategoris({
    Key? key,
    required this.title,
    required this.price,
    required this.comparePrice,
    required this.name,
    required this.quantity,
    required this.image,
  }) : super(key: key);

  final String title;
  final String price;
  final String comparePrice;
  final String name;
  final String quantity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
padding: EdgeInsets.only(top: 5),
            width: double.infinity,
            child: Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,alignment: Alignment.center
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'السعر: $price',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  'خصم: $comparePrice',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  'الكمية: $quantity',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
