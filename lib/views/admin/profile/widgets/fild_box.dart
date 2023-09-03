
import 'package:flutter/material.dart';

class FieldBox extends StatelessWidget {
  const FieldBox({
    super.key,
    required this.line,
    required this.txt,
    required this.type,
  });

  final int line;
  final String txt;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: type,
        maxLines: line,
        decoration: InputDecoration(
            fillColor: const Color.fromARGB(79, 153, 153, 160),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            label: Text(txt)));
  }
}
