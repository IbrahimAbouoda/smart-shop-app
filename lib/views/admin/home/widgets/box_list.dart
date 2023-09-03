
  import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Container BoxContList() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 1.5)),
        width: 350,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.delete,
                      ),
                      Icon(Icons.note_alt_outlined)
                    ],
                  ),
                  const Text("15"),
                  const Text("\$366"),
                  const Text("الفضي"),
                  const Text("فستان"),
                  Image.asset("assets/images/fustan.png")
                ],
              ),
            ),
          ],
        ));
  }
