
import 'package:flutter/material.dart';

class NewListCategoris extends StatelessWidget {
  const NewListCategoris({
    Key? key,
    required this.title,
    required this.price,
    required this.comparePrice,
    required this.name,
    required this.quantity,
    required this.image,
  }) : super(key: key);

  final String title;
  final String price;
  final String comparePrice;
  final String name;
  final String quantity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 5),
            width: double.infinity,
            child: Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                    image,
                    fit: BoxFit.cover,alignment: Alignment.center
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'السعر: $price',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  'خصم: $comparePrice',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  'الكمية: $quantity',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
