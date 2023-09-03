import 'package:flutter/material.dart';

import '../../core/utils/constant.dart';

class TopBarUser extends StatelessWidget {
  const TopBarUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 70,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add),
            color: ConstantStayles.kPrimColor,
          )
        ],
      ),
    );
  }
}
