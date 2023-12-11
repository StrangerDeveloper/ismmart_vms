import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static const primary = Color(0xffE88C43);

  static const MaterialColor plattet1 =
      MaterialColor(_platter1PrimaryValue, <int, Color>{
    50: Color(0xFFFDECEB),
    100: Color(0xFFFAD0CE),
    200: Color(0xFFF7B1AD),
    300: Color(0xFFF3928C),
    400: Color(0xFFF17A74),
    500: Color(_platter1PrimaryValue),
    600: Color(0xFFEC5B53),
    700: Color(0xFFE95149),
    800: Color(0xFFE74740),
    900: Color(0xFFE2352F),
  });
  static const int _platter1PrimaryValue = 0xFFEE635B;
  static const lightGrey = Color(0xff929AAB);
  static const fadedBlue = Color(0xff5D738A);
  // static Gradient gradient1 = const LinearGradient(
  //   begin: Alignment(-1.064, -0.951),
  //   end: Alignment(1, 1),
  //   colors: <Color>[Color(0xffe79141), Color(0xfff05f5f)],
  //   stops: <double>[0, 1],
  // );

}

var newFontStyle0 = GoogleFonts.dmSans(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);