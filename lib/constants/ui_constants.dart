import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double maxPageWidth = 220.0;
const double spaceFormInput = 15.0;
const primaryColor = Color.fromARGB(255, 72, 101, 230);

class AppStyle {
  static Color bgColor = const Color(0xFFe2e2ff);
  static Color mainColor = const Color(0xFF000633);
  static Color accentColor = const Color(0xFF0065FF);

  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];

  static TextStyle mainTitle =
      GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold);
  static TextStyle separatorText =
      GoogleFonts.nunito(fontSize: 25.0, fontWeight: FontWeight.w600);
  static TextStyle phoneTitle = GoogleFonts.roboto(
      fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.grey[600]);
  static TextStyle dataText = GoogleFonts.roboto(
      fontSize: 17.0, fontWeight: FontWeight.w400, color: Colors.black87);
  static TextStyle dniTitle =
      GoogleFonts.roboto(fontSize: 12.0, fontWeight: FontWeight.bold);
  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);
  static TextStyle inputTextStyle =
      GoogleFonts.roboto(fontSize: 10.0, fontWeight: FontWeight.w500);

  // Headers textStyle

  static TextStyle headerTextStyle = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle titlesH1 = GoogleFonts.lato(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle titlesH2 = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle paragraph1 = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle paragraph2 = GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle textOut1 = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade100,
  );

  static TextStyle textIn1 = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
  );
}

const textStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 15.0,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

final inputTextStyle = GoogleFonts.roboto(
    fontSize: 13.0,
    color: const Color.fromARGB(255, 60, 111, 136),
    fontWeight: FontWeight.w500);

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        gapPadding: 0,
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 5,
        )));
