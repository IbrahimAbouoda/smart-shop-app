
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/constant.dart';

class CardChats extends StatelessWidget {
  const CardChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: CircleAvatar(
          child: Image.asset(Assets.imagesDefin1),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.safety_check),
            Text(
              "هل يوجد كميات كبيرة",
              style: ConstantStayles.subTitle,
            ),
          ],
        ),
        title: Text("Ibrahim", style: ConstantStayles.title),
        trailing: const Text("11/19"),
      ),
      const Divider(
        color: Colors.black12,
      )
    ]);
  }
}
