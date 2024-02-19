import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),

  dividerColor: Colors.white54,
  appBarTheme:  AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: GoogleFonts.lemonada(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  textTheme:  TextTheme(

    bodyLarge: GoogleFonts.lemonada(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.lemonada(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

  ),
);