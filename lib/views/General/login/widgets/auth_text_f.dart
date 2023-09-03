import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextField extends StatelessWidget {
  String hint;

  TextEditingController controller;
  AuthTextField({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade400),
          hintText: hint,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3A98B9)))),
    );
  }
}
