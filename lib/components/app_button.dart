import 'package:flutter/material.dart';
import '../core/utils/constant.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? border;
  final Function() onPressed;

  const AppButton({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.border,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 50,
        decoration: backgroundColor == null
            ? BoxDecoration(
                border: Border.all(
                  color: border ?? backgroundColor ?? ConstantStayles.kPrimColor,
                  width: 2,
                ),
                color: ConstantStayles.kPrimColor,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              )
            : BoxDecoration(
                border: Border.all(
                  color: border ?? backgroundColor ?? ConstantStayles.kPrimColor,
                  width: 2,
                ),
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
