
import 'package:flutter/material.dart';

import '../../../core/utils/constant.dart';

class CardPay extends StatelessWidget {
  const CardPay({
    super.key,
    required this.cartData,
    required this.price,
    required this.backgroundColor,
  });

  final Map<String, dynamic> cartData;
  final double price;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xff9ca9c7),
        borderRadius: BorderRadius.circular(5),
        border:
        Border.all(color: ConstantStayles.kPrimColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              // Image.network(cartData['image']),
              Text(
                cartData['name'],
                style: ConstantStayles.styleDark,
              ),
              Image.network(
                cartData['image'],
                height: 50,
                width: 50,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("قطعة: ${cartData['quantity']}"),
              Text("\$${price}"),
            ],
          ),

          Column(
            children: [
              IconButton(
                onPressed: () {
                  // Handle delete action here
                },
                icon: Icon(
                  Icons.delete,
                  size: 30,
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
