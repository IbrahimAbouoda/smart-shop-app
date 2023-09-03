// ignore: must_be_immutable
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  String hint;
  TextEditingController controller;
  bool obscureText; // تمثيل حالة إخفاء النص (كلمة المرور)
final TextInputType? keyboardType;
  AuthTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscureText = false, this.keyboardType, // القيمة الافتراضية لعرض النص
  });

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}
class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    // قرر متى يجب عرض أيقونة "إظهار كلمة المرور"
    final bool showVisibilityIcon =
        widget.keyboardType == TextInputType.visiblePassword;

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey.shade400),
        hintText: widget.hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff3A98B9)),
        ),
        // إضافة رمز عرض/إخفاء إلى الحقل إذا كانت الحالة تسمح بهذا
        suffixIcon: showVisibilityIcon
            ? IconButton(
                onPressed: () {
                  setState(() {
                    // تبديل حالة عرض النص
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: Icon(
                  widget.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey.shade400,
                ),
              )
            : null,
      ),
    );
  }
}


