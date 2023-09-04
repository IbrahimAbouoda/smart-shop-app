import 'package:flutter/material.dart';


import '../../../../core/shared_preferences/shared_preferences.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';

class NewListCategories extends StatelessWidget {
  const NewListCategories({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    

    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: Text(title, style: const TextStyle(fontSize: 20)),
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: FutureBuilder<List<ProductModel>>(
            future: ProductService().getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available.'));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                  SharedPrefController prefController = SharedPrefController(); // Create an instance of SharedPrefController

                    return InkWell(
                      onTap: () {
                        prefController.saveProductData(
                          product.name, // Use product name
                          product.price, // Use product price
                          product.imageUrl, // Use product image URL
                        );

                        Navigator.pushNamed(context, "/details_product");
                      },
                      child: CardNewProducts(
                        quantity: product.quantity,
                        name: product.name,
                        comparePrice: product.comparePrice,
                        price: product.price,
                        image: product.imageUrl,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CardNewProducts extends StatelessWidget {
  const CardNewProducts({
    Key? key,
    required this.name,
    required this.price,
    required this.comparePrice,
    required this.image,
    required this.quantity,
  });

  final String name;
  final double price;
  final double comparePrice;
  final String image;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 270,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffD9D9D9),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 200,
            child: (image != null && image.isNotEmpty)
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                  )
                : Placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "$quantity",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    Text(
                      "\$ $price",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    Text(
                      "\$ $comparePrice",
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
