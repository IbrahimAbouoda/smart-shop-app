import 'package:flutter/material.dart';

class CardShowUserSels extends StatelessWidget {
  final String name;
  final Function()? onDoubleTap;
  final Function()? onPressedAdd;
  final Function()? onPresseddelte;
  const CardShowUserSels(
      {Key? key,
      required this.name,
      this.onDoubleTap,
      required this.onPressedAdd,
      required this.onPresseddelte})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(onPressed: onPressedAdd, child: const Text("اضافة")),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name),
                  const CircleAvatar(
                    backgroundColor: Colors.cyanAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
