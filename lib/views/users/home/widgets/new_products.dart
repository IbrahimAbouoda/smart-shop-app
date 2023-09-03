import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';

class NewListCategoris extends StatelessWidget {
  const NewListCategoris({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List images = [
      Assets.images,
      Assets.imagesFustan,
      Assets.man2_1,
      Assets.man2
    ];
    // ignore: unused_local_variable
    final ProductService productService = ProductService();
    final Future<List<ProductModel>> products = ProductService().getProducts();

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
            future: products,
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
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return CardNewProducts(
                      quntity: product.quantity,
                      name: product.name,
                      compasrPrice: product.comparePrice,
                      price: product.price,
                      image: images[index],
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}

class CardNewProducts extends StatelessWidget {
  const CardNewProducts({
    super.key,
    required this.name,
    required this.price,
    required this.compasrPrice,
    required this.image,
    required this.quntity,
  });

  final String name;
  final double price;
  final double compasrPrice;
  final String image;
  final int quntity;
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
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
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
                    Text("$quntity",
                        style: const TextStyle(color: Colors.blue)),
                    Text(
                      "\$ $price",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    Text(
                      "\$ $compasrPrice",
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
