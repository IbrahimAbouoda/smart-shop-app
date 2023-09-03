import 'package:flutter/material.dart';
import '../../../../../components/general_widgets.dart';
import '../../../../core/utils/constant.dart';
import '../../../../models/product_model.dart';
import '../../../../service/backend/product_service.dart';
import '../widgets/box_list_image.dart';
import '../widgets/text_fiald.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductService productService = ProductService();

  late Future<List<ProductModel>> products;
  final _formKey = GlobalKey<FormState>();

  TextEditingController? nameController;
  TextEditingController? decController;
  TextEditingController? priceController;
  TextEditingController? quantityController;
  TextEditingController? companyController;
  TextEditingController? statusController;
  TextEditingController? pricController;
  TextEditingController? comparePriceController;
  TextEditingController? quntityController;
  TextEditingController? sizeController;
  TextEditingController? khamaController;
  TextEditingController? partController;

  @override
  void initState() {
    products = productService.getProducts();
    nameController = TextEditingController();
    decController = TextEditingController();
    companyController = TextEditingController();
    statusController = TextEditingController();
    priceController = TextEditingController();
    comparePriceController = TextEditingController();
    sizeController = TextEditingController();
    quntityController = TextEditingController();
    partController = TextEditingController();
    khamaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController;
    decController;
    companyController;
    statusController;
    priceController;
    comparePriceController;
    sizeController;
    quntityController;
    partController;
    khamaController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 20, right: 40, left: 40),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BoxImageCont(
                            radis: 15,
                            hightBox: 50,
                            widthBox: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          BoxImageCont(
                            radis: 15,
                            hightBox: 50,
                            widthBox: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          BoxImageCont(
                            radis: 15,
                            hightBox: 50,
                            widthBox: 50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    BoxImageCont(radis: 50, hightBox: 200, widthBox: 200),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormProduct(
                  maxline: 1,
                  label: "اسم المنتج",
                  width: 300,
                  controller: nameController,
                ),
                TextFormProduct(
                  maxline: 2,
                  label: "الوصف",
                  width: 300,
                  controller: priceController,
                ),
                TextFormProduct(
                  maxline: 1,
                  width: 400,
                  label: "الشركة المصنعة",
                  controller: companyController,
                ),
                const TextFormProduct(
                  maxline: 1,
                  width: 400,
                  label: " اللون",
                  controller: null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFormProduct(
                      maxline: 1,
                      width: 80,
                      label: " الظهور",
                      controller: statusController,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFormProduct(
                      maxline: 1,
                      width: 80,
                      label: "السعر",
                      controller: pricController,
                    )),
                    Expanded(
                        child: TextFormProduct(
                            maxline: 1,
                            width: 80,
                            label: "  بعد الخصم",
                            controller: comparePriceController)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFormProduct(
                      maxline: 1,
                      width: 80,
                      label: " الكمية",
                      controller: quntityController,
                    )),
                    Expanded(
                        child: TextFormProduct(
                            maxline: 1,
                            width: 80,
                            label: "  المقاس",
                            controller: sizeController)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFormProduct(
                      maxline: 1,
                      width: 80,
                      label: " الخامة",
                      controller: khamaController,
                    )),
                    Expanded(
                        child: TextFormProduct(
                      maxline: 1,
                      width: 80,
                      label: "  القسم",
                      controller: partController,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {

                    // Navigator.pushNamed(context, "/AddProduct2");

                    await productService.postProduct(product);
                    // };
                  },
                  text: "متابعة",
                  color: ConstantStayles.kPrimColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "رجوع",
                      style: ConstantStayles.style1,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final product = ProductModel(
    id: 123, // Replace with the actual product ID
    storeId: 9,
    categoryId: 3,
    name: "Sample Product",
    slug: "sample-product",
    price: 25.0,
    comparePrice: 30.0,
    quantity: 50,
    status: "active",
    type: "general",
    notes: "This is a sample product.",
    size: 10,
    manufacturerCompany: "Sample Manufacturer",
    productMaterial: "Sample Material",
    rating: 5,
    featured: 1,
    options: null,
    imageUrl: "",
    category:
        Category(3, "Sample Category", "https://example.com/category.jpg"),
    store: Store(9, "Sample Store", "https://example.com/store.jpg"),
    tags: [
      Tag(1, "Tag1"),
      Tag(2, "Tag2"),
    ],
  );
}
