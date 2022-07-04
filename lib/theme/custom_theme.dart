import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,

      primaryColor: Colors.white,
      // These are the color of the ISATI
      cardColor: Colors.white,

      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),

      textTheme: TextTheme(
          headline1: GoogleFonts.lato(
              fontSize: 48.0,
              fontWeight: FontWeight.w800,
              color: Colors.black87),
          headline2: GoogleFonts.lato(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: Colors.black87),
          subtitle1: GoogleFonts.lato(
              fontSize: 26.0,
              fontWeight: FontWeight.w800,
              color: Colors.black87)),

      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xfff70c36)),
    );
  }
}
