import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class GeneralStyle {
  static TextStyle tiltelStyle = GoogleFonts.cairo(
      textStyle: const TextStyle(fontSize: 25), fontWeight: FontWeight.w600);
  static const hintStyle = TextStyle(
    fontSize: 20,
  );
  static const fontButton = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );
}
