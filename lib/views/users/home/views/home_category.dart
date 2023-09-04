import 'package:flutter/material.dart';
import '../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';
import '../widgets/categoris_list.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final Future<List<ProductModel>> products = productService.getProducts();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBarUserPages(
            onPressed: () => Navigator.pushNamed(context, "/menuUser"),
          ),
        ),
        body: Column(children: [
          ChoosTager(onTap: () {
            Navigator.pushNamed(context, "/homeAdmin");
          }),
          Expanded(
              flex: 6,
              child: FutureBuilder<List<ProductModel>>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No users available.'));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final product = snapshot.data![index];
                            return GestureDetector(
                              child: NewListCategoris(
                                image: product.imageUrl,
                                title: "الترند",
                                comparePrice: product.comparePrice.toString(),
                                name: product.name,
                                price: product.price.toString(),
                                qutity: product.quantity.toString(),
                              ),
                              onTap: () =>
                                  Navigator.pushNamed(
                                      context, "/details_product"),
                            );
                          });
                    }
                  })),
          ButtonAppBar1(
              onTapHome: () => Navigator.pushNamed(context, "/homeUser")
          )
          ,
        ]
        )
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
    required this.qutity,
    required this.image,
  }) : super(key: key);
  final String title;
  final String price;
  final String comparePrice;
  final String name;
  final String qutity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/details_product"),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Text(title, style: const TextStyle(fontSize: 20)),
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Container(
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
                    child: Image.network(
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
                            Text(qutity,
                                style: const TextStyle(color: Colors.blue)),
                            Text(
                              "\$$price",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            Text(
                              "\$$comparePrice",
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
            ),
          )
        ],
      ),
    );
  }
}
