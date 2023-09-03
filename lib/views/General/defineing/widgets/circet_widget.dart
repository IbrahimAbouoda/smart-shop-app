
import 'package:flutter/material.dart';

class Circet extends StatelessWidget {
  const Circet({
    super.key,
    required this.index1,
  });

  final int index1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: index1 == 0 ? Colors.black : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: Colors.black),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: index1 == 0 ? Colors.black : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: index1 == 0 ? Colors.black : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}