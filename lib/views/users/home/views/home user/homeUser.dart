import 'package:flutter/material.dart';
import 'package:gaza_shop/views/users/home/views/home%20user/serch_store.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../../../components/general_widgets_user.dart/app_bar_user.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../models/product_model.dart';
import '../../../../../models/stores_model.dart';
import '../../../../../service/backend/product_service.dart';
import '../../../../../service/backend/store_servic.dart';
import '../../widgets/categoris_list.dart';
import '../../widgets/new_list_home.dart';

class HomeUser extends StatefulWidget {
  static const String id = "/homeUser";

  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final productService = ProductService();
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first initialized
    products = productService.getProducts();
  }

  void _startSearch(BuildContext context) async {
    final storeService = StoreService();
    final List<StoreModel> stores = await storeService.getStores();

    showSearch(
      context: context,
      delegate: StoreNameSearchDelegate(stores),
    ).then((selectedStore) {
      if (selectedStore != null) {
        // Handle the selected store (e.g., navigate to a store details page)
        print('Selected store: ${selectedStore.name}');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // ...
    return Scaffold(
      appBar: AppBar(
        title: Text("الصفحة الرئيسية"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // The _startSearch function should be called directly here, no need for setState.
              _startSearch(context);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          ChoosTager(onTap: () {
            Navigator.pushNamed(context, "/homeAdmin");
          }),
          Container(
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Text("الترند", style: GoogleFonts.alexBrush(fontSize: 25)),
                Image.asset(Assets.trend, height: 30, width: 30),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      ProductModelDetails dataProduct = ProductModelDetails(
                        id: product.id ?? 0,
                        name: product.name ?? "",
                        note: product.notes ?? "",
                        price: product.price ?? 0,
                        imageUrl: product.imageUrl ?? "",
                        quantity: product.quantity ?? 0,
                        material: product.productMaterial ?? "",
                      );
                      return GestureDetector(
                        child: NewListHome(
                          image: product.imageUrl ?? "",
                          comparePrice: product.comparePrice.toString() ?? 0,
                          name: product.name ?? "",
                          price: product.price.toString() ?? 0,
                          qutity: product.quantity.toString() ?? 0,
                        ),
                        onTap: () =>
                            Navigator.pushNamed(
                              context,
                              "/details_product",
                              arguments: dataProduct,
                            ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ButtonAppBar1(
            onTapHome: () => Navigator.pushNamed(context, "/homeUser"),
          ),
        ],
      ),
    );
  }
}