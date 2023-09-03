import 'package:flutter/material.dart';


import '../../../../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../../../../core/utils/app_images.dart';

class DetailsProduct extends StatelessWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: TopBarApp1(
                titel: "صفحة المنتج",
              ),
            )),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  height: 364,
                  Assets.man2,
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
                      Image.asset(Assets.man2_1),
                      Image.asset(Assets.man2_1),
                      Image.asset(Assets.man2_1),
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
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          "قميص نص مشجر",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "رجالي",
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: const Text(
                          "قميص نص كم مشجر خامة قطنية 100% مستورد من \n تركيا العدد محدود جدا ",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ))),
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
}
