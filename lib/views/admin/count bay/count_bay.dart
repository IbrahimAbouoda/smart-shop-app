import 'package:flutter/material.dart';
import 'package:gaza_shop/views/admin/count%20bay/widgets/card_details.dart';

import '../../../components/widgets/general_widgets/app_bar1.dart';
import '../../../components/widgets/general_widgets/buttonApp.dart';
import 'widgets/list_card_bay.dart';

class CounterBay extends StatelessWidget {
  const CounterBay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        const TopBarApp1(titel: "احصائية المشتري"),
        const SizedBox(
          height: 20,
        ),
        const CardDetails(),
        const ListCardBay(),
        ButtonAppBar1(
            onTapHome: () => Navigator.pushNamed(context, "/homeadmin"))
      ]),
    );
  }
}
