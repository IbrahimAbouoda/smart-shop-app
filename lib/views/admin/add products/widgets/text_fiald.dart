import 'package:flutter/material.dart';

import '../../../../../core/utils/constant.dart';

class TextFormProduct extends StatelessWidget {
  final int maxline;
  final double width;
  final String label;
  final TextEditingController? controller;
  const TextFormProduct({
    super.key,
    required this.maxline,
    required this.label,
    required this.width,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: ConstantStayles.kPrimColor, fontSize: 15),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a data';
              }
              return null;
            },
            controller: controller,
            textAlign: TextAlign.right,
            maxLines: maxline,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: ConstantStayles.kPrimColor))),
          ),
        ],
      ),
    );
  }
}
