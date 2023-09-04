import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantStayles {
  static const Color kPrimColor = Color(0xff27374D);
  static const String kFeatuerdBox = 'featuerd_box';
  static TextStyle style1 =
      GoogleFonts.poppins(color: Colors.black, fontSize: 15);
  static TextStyle styleLight =
      GoogleFonts.poppins(color: Colors.white, fontSize: 15);
  static TextStyle styleDark =
      GoogleFonts.poppins(color: Colors.black, fontSize: 20);

  static TextStyle title =
      GoogleFonts.akayaTelivigala(color: Colors.black, fontSize: 20);
  static TextStyle subTitle = GoogleFonts.poppins(
      color: const Color.fromARGB(255, 61, 58, 58), fontSize: 15);

      static  BoxDecoration kMessageContainerDecoration = const BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

static InputDecoration kMessageTextFieldDecoration = const InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);


static const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
}
