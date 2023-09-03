import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhoME extends StatelessWidget {
  const WhoME({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("من نحن"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "نحن الابااااااااء جند محمد",
            style: GoogleFonts.aBeeZee(fontSize: 40),
          ),
          const Text("------------------"),
        ]),
      ),
    );
  }
}
