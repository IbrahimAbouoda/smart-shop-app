
  import 'package:flutter/material.dart';

Column dropdownBox(double i, String tex) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Text(tex, textAlign: TextAlign.right)),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          width: i,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF3F3F3),
          ),
          child: const Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
