import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color redClr = Color(0xffFF6464);
const Color pinkClr = Color(0xFFff64a5); //0xFFff4667
const Color orangeClr = Color(0xFFff8964);
const Color purpleClr = Color(0xFFc464ff);
const Color blueClr = Color(0xFF6498ff);
const Color greenClr = Color(0xFF51f4a5);
const Color white = Colors.white;
const Color primaryClr = redClr;
const Color darkGreyClr = Color(0xFF181818);
const Color lightGreyClr = Color(0xFF282828);
const Color inputFieldClr = Color(0xFFf3f3f3);
const Color inputTextClr = Color(0xFF14181B);
const Color inputHintClr = Color(0x80000000);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  )));
}

TextStyle get inputTextStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: inputTextClr,
  )));
}

TextStyle get inputHintStyle {
  return GoogleFonts.lato(
      textStyle: (TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: inputHintClr,
  )));
}
