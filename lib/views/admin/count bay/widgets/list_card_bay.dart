import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_images.dart';

class ListCardBay extends StatelessWidget {
  const ListCardBay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 127, 155, 199),
            border: Border.all(),
            borderRadius: BorderRadius.circular(2)),
        margin: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())),
            const Column(
              children: [
                Text("الكمية/400"),
                Text("\$السعر/200"),
              ],
            ),
            const Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Assets.c1),
                ),
                Text("قميص")
              ],
            )
          ],
        ),
      ),
    ));
  }
}
