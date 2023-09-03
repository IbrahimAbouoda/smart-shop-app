import 'package:flutter/material.dart';

import '../../../../../../components/widgets/general_widgets/buttonApp.dart';
import '../widgets/card_chats.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المراسلات"),
      ),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/messageing");
                },
                child: const CardChats());
          },
        )),
        ButtonAppBar1(
            onTapHome: () => Navigator.pushNamed(context, "/homeUser")),
      ]),
    );
  }
}
