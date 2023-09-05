import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gaza_shop/models/product_model.dart';
import 'package:gaza_shop/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../admin/details/details_product_admin.dart';

class DetailsProductUser extends StatelessWidget {
  late String name;
  late double price;
  late int quntity;
  String? color;
  late String image;

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    final ProductModelDetails productDetails =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as ProductModelDetails;
    String note = productProvider.removeHtmlTags(productDetails.note);
    int countQuantity = productProvider.countQuntiy;

    name = productDetails.name;
    image = productDetails.imageUrl;
    price = productDetails.price;
    quntity = productDetails.quantity;
    return Scaffold(
        appBar: AppBar(title: Text("صفحة المنتج")),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: ConstantStayles.kPrimColor)),
                    width: double.infinity,
                    child: Image.network(
                      productDetails.imageUrl,
                      width: 100,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.red)),
                                child: Row(
                                  children: [
                                    Text("سعر القطعة",
                                        style: ConstantStayles.styleDark),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${productDetails.price}",
                                        style: ConstantStayles.styleDark),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.red)),
                                child: Row(
                                  children: [
                                    Text("السعر الكلي",
                                        style: ConstantStayles.styleDark),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${countQuantity * price}",
                                        style: ConstantStayles.styleDark),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.red)),
                                child: Row(
                                  children: [
                                    Text("الكمية المتاحة",
                                        style: ConstantStayles.styleDark),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("${productDetails.quantity}",
                                        style: ConstantStayles.styleDark),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (quntity > countQuantity) {
                                    productProvider.incCount();
                                  } else {
                                    productProvider.onAlertWithStylePressed(
                                        context, "انتبه !!",
                                        "الكمية أعلى من المتاح", "تراجع");
                                  }
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red)),
                                  child: Row(
                                    children: [
                                      Text("+ المطلوبة",
                                          style: ConstantStayles.styleDark),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${countQuantity}",
                                          style: ConstantStayles.styleDark),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: IconButton(
                                            icon: Icon(Icons.minimize_rounded),
                                            onPressed: () {
                                              if (quntity >=
                                                  countQuantity) {
                                                productProvider.decCount();
                                              }
                                              if (countQuantity <= 1) {
                                                productProvider.onAlertWithStylePressed(
                                                    context, "انتبه",
                                                    "لم تطلب بعد", "تراجع");
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                          Border.all(color: ConstantStayles.kPrimColor)),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DataDetailsText(productDetails: name),
                          SizedBox(
                            height: 5,
                          ),
                          DataDetailsText(productDetails: note),
                          SizedBox(
                            height: 5,
                          ),
                          DataDetailsText(
                              productDetails: productDetails.material),
                        ],
                      ),
                    ))),
            GestureDetector(
              onTap: () {
               if(productProvider.countQuntiy <=0){
                 productProvider.onAlertWithStylePressed(context, "انتبه", "لم تضف الكمية بعد", "رجوع");
               }else{
                 productProvider.addToCart(
                     context,
                     name,
                     image,
                     countQuantity,
                     price * countQuantity,
                     color ?? "black"); // Call addToCart method
                 Navigator.pushNamed(context, "/carPay");
                 productProvider.countQuntiy=0;
               }
              },
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: 200,
                decoration: BoxDecoration(
                    color: ConstantStayles.kPrimColor,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اضافة الى السلة",
                      style: GoogleFonts.poppins(
                          fontSize: 25, color: Colors.white),
                    ),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.topRight,
                        child: const Text(
                          "الالوان المتوفرة",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => color = "orange",
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.orange,
                              ),
                            ),
                            InkWell(
                              onTap: () => color = "purpleAccent",
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.purpleAccent,
                              ),
                            ),
                            InkWell(
                              onTap: () => color = "limeAccent",
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.limeAccent,
                              ),
                            ),
                            InkWell(
                              onTap: () => color = "blueAccent",
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                            InkWell(
                              onTap: () => color = "black",
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

}