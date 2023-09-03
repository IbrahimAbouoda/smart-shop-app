import 'package:flutter/material.dart';

class ButtonAppBar1 extends StatelessWidget {
  const ButtonAppBar1({
    super.key,
    required this.onTapHome,
  });
  final Function()? onTapHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xff27374D),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        InkWell(
          onTap: onTapHome,
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/profile"),
          child: const Icon(
            Icons.person_2,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/carPay"),
          child: const Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
        ),
        InkWell(
            onTap: () => Navigator.pushNamed(context, "/chats"),
            child: const Icon(
              Icons.chat_sharp,
              color: Colors.white,
            )),
      ]),
    );
  }
}
