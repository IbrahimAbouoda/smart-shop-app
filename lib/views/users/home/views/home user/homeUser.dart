import 'package:flutter/material.dart';
import 'package:gaza_shop/core/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../models/product_model.dart';
import '../../../../../service/backend/product_service.dart';
import '../../widgets/categoris_list.dart';
import '../home category/widgets/choos_part.dart';
import '../../widgets/new_products.dart';
import '../home category/home_category.dart';

class HomeUser extends StatelessWidget {
  static const String id = "/homeUser";

  const HomeUser({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          ChoosTager(onTap: () {
            Navigator.pushNamed(context, "/homeAdmin");
          }),
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child:  Row(
              children: [
                Text("الترند",style: GoogleFonts.alexBrush(fontSize: 25),),
                Image.asset(Assets.trend,height: 30,width: 30,)
              ],
            ),),
          Expanded(
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
                            ProductModelDetails dataProduct = ProductModelDetails(
                                id: product.id,
                                name: product.name,
                                note: product.notes,
                                price: product.price,
                                imageUrl: product.imageUrl,
                                quantity: product.quantity,
                            material: product.productMaterial);
                            return GestureDetector(
                              child: NewListHome(
                                image: product.imageUrl,
                                comparePrice: product.comparePrice.toString(),
                                name: product.name,
                                price: product.price.toString(),
                                qutity: product.quantity.toString(),
                              ),
                              onTap: () =>
                                  Navigator.pushNamed(
                                    context, "/details_product",arguments: dataProduct),
                            );
                          });
                    }
                  })),


          ButtonAppBar1(
            onTapHome: () => Navigator.pushNamed(context, "/homeUser"),
          ),
        ],
      ),
    );
  }
}

class NewListHome extends StatelessWidget {
  const NewListHome(
      {super.key,  this.price, this.comparePrice, this.image, this.qutity, this.name});


  final price;
  final comparePrice;
  final image;
  final qutity;
  final name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Column(
        children: [

          SizedBox(
            width: double.infinity,
            height: 400,
            child: Container(
              margin: EdgeInsets.all(10),
              height: 270,
              width: 210,
              decoration: BoxDecoration(
                border: Border.all(color: ConstantStayles.kPrimColor),
                borderRadius: BorderRadius.circular(15),

              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: image != null ? Image.network(image,height: 50,width: 50,fit: BoxFit.cover,) : Image.asset(
                        Assets.logo),
                  ),
                  Column(
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
                            Text("$qutity قطعة ",
                                style: const TextStyle(color: Colors.blue)),
                            Text(
                              "\$$comparePrice",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            Text(
                              "\$$price",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ],
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
