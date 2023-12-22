import 'package:flutter/material.dart';

class ThemeHelper {
  static const primary = Color(0xffE88C43);
  static const blue1 = Color(0xff3669C9);
  static const grey1 = Color(0xffEEEEEE);
  static const grey2 = Color(0xff929AAB);
  static const grey3 = Color(0xffF9FAFB);
  static const grey4 = Color(0xFF6F6F6F);
  static const red1 = Color(0xFFFE3A30);

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