import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/constant.dart';

// ignore: camel_case_types
class actionBarMessg extends StatelessWidget {
  const actionBarMessg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Ibrahim",
          style: ConstantStayles.styleLight,
        ),
        const SizedBox(
          width: 20,
        ),
        const CircleAvatar(
          backgroundImage: AssetImage(Assets.imagesDefin1),
        ),
        const SizedBox(
          width: 20,
        ),
        const IconButtonForword(),
      ],
    );
  }
}

class IconButtonForword extends StatelessWidget {
  const IconButtonForword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/chats");
      },
      icon: const Icon(Icons.arrow_forward),
      color: Colors.white,
    );
  }
}
