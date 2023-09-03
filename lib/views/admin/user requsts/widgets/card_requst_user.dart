import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/constant.dart';

class CardRequst extends StatelessWidget {
  final String name;
  final String type;
  final String image;
  const CardRequst({
    super.key,
    required this.name,
    required this.type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: ConstantStayles.kPrimColor),
            borderRadius: BorderRadius.circular(5)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(DateFormat('yyyy-MM-dd HH:mm').format(dateTime)),
                MaterialButton(
                  onPressed: () {},
                  color: ConstantStayles.kPrimColor,
                  child: const Text(
                    "حذف",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(name),
                Text(
                  type,
                  style: const TextStyle(color: Colors.black),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/chats");
                  },
                  color: ConstantStayles.kPrimColor,
                  child: const Text(
                    "قبول",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(image),
            ),
          )
        ]),
      ),
    );
  }
}
