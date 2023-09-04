import 'package:flutter/material.dart';

import '../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../../../core/utils/constant.dart';
import '../../../models/product_model.dart';
import '../../../service/backend/product_service.dart';

class CarPayProduct extends StatelessWidget {
  const CarPayProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final Future<List<ProductModel>> products = productService.getProducts();
    return Scaffold(
      appBar: AppBar(title: Text("سلة المشتريات"),),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),

        Expanded(
          flex: 8,
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ConstantStayles.kPrimColor)),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.delete),
                    Text("52"),
                    Text("\$50"),
                    Text("فستانه طويل مفتوح"),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                    )
                  ]),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Row(children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(8),
                      color: ConstantStayles.kPrimColor,
                      child:  Text("شراء الان",style: ConstantStayles.styleLight,))),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(8),
                      color: ConstantStayles.kPrimColor,
                      child:  Text("اجمالي المبلغ 600",style: ConstantStayles.styleLight,))),
            ])),
        Expanded(
            flex: 1,
            child: ButtonAppBar1(
                onTapHome: () => Navigator.pushNamed(context, "/homeUser")))
      ]),
    );
  }
}
