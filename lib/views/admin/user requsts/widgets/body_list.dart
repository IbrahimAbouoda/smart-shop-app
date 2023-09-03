
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_images.dart';
import 'card_requst_user.dart';

class BodyRequstList extends StatelessWidget {
  const BodyRequstList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => const CardRequst(
              image: Assets.general, name: "محمد", type: "عام"),
        )),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => const CardRequst(
              image: Assets.silver, name: "احمد", type: "فضي"),
        )),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => const CardRequst(
              image: Assets.gold, name: "ابراهيم", type: "ذهبي"),
        )),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => const CardRequst(
              image: Assets.medal, name: "سعيد", type: "الماسي"),
        )),
      ],
    );
  }
}
