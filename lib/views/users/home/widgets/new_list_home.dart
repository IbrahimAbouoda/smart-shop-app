
import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/constant.dart';

class NewListHome extends StatelessWidget {
  const NewListHome({
    Key? key,
    required this.price,
    required this.comparePrice,
    required this.image,
    required this.qutity,
    required this.name,
  });

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
                    child: image != null
                        ? Image.network(image, height: 50, width: 50, fit: BoxFit.cover)
                        : Image.asset(Assets.logo),
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
                          Text("$qutity قطعة ", style: const TextStyle(color: Colors.blue)),
                          Text(
                            "\$$comparePrice",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          Text(
                            "\$$price",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                            ),
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
