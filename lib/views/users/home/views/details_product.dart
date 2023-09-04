import 'package:flutter/material.dart';
import 'package:gaza_shop/models/product_model.dart';
import 'package:gaza_shop/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../core/utils/constant.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var productProvider =Provider.of<ProductProvider>(context);
    final ProductModelDetails productDetails = ModalRoute.of(context)?.settings.arguments as ProductModelDetails;
   String note=productProvider.removeHtmlTags(productDetails.note);
    return Scaffold(
        appBar: AppBar(title: Text("صفحة المنتج")),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.red)),
                    width: double.infinity,
                    child: Image.network(
                      productDetails.imageUrl,width: 100,height: 200,fit: BoxFit.cover,
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
                         Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.red)),
                           child: Row(
                             children: [
                               Text("السعر",style: ConstantStayles.styleDark),SizedBox(width: 5,),
                               Text("${productDetails.price}",style: ConstantStayles.styleDark),
                             ],
                           ),
                         ),
                         Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.red)),
                           child: Row(
                             children: [
                               Text("الكمية المتاحة",style: ConstantStayles.styleDark),SizedBox(width: 5,),

                               Text("${productDetails.quantity}",style: ConstantStayles.styleDark),
                             ],
                           ),
                         ),

                        ],
                      ),
                    ))),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.indigo)),
                            alignment: Alignment.topRight,
                            child:  Text(
                              "${productDetails.name}",
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueAccent)),
                            alignment: Alignment.centerRight,
                            child:  Text(
                              "${note}",style: ConstantStayles.styleDark,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.red)),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "قميص نص كم مشجر خامة قطنية 100% مستورد من \n تركيا العدد محدود جدا ",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ))),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/carPay"),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width:200,
                decoration:
                BoxDecoration(color: ConstantStayles.kPrimColor,borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "اضافة الى السلة",
                      style: GoogleFonts.poppins(fontSize: 25,color: Colors.white),
                    ),
                     Icon(Icons.add_shopping_cart,color: Colors.white,),
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
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black87,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.deepOrange,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blueGrey,
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
  void addToCart(String name,String image,String price,String quntity){

  }
}
