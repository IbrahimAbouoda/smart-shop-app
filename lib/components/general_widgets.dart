import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key, required this.text, this.onPressed, required this.color});

  final String text;
  final Function()? onPressed;
  final Color color;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(widget.color)),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize:20),
        ),
      ),
    );
  }
}
