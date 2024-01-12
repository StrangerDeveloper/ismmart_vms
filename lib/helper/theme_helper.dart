import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static const primary = Color(0xffE88C43);
  static const blue1 = Color(0xff3669C9);
  static const grey1 = Color(0xffEEEEEE);
  static const grey2 = Color(0xff929AAB);
  static const grey3 = Color(0xffF9FAFB);
  static const grey4 = Color(0xFF6F6F6F);
  static const grey5 = Color(0xFF6B7280);
  static const grey6 = Color(0xFFE5E7EB);
  static const red1 = Color(0xFFFE3A30);
  static const lightGrey = Color(0xff929AAB);
  static const fadedBlue = Color(0xff5D738A);

  static const MaterialColor plattet1 =
      MaterialColor(_platter1PrimaryValue, <int, Color>{
    50: Color(0xFFE7EDF9),
    100: Color(0xFFC3D2EF),
    200: Color(0xFF9BB4E4),
    300: Color(0xFF7296D9),
    400: Color(0xFF5480D1),
    500: Color(_platter1PrimaryValue),
    600: Color(0xFF3061C3),
    700: Color(0xFF2956BC),
    800: Color(0xFF224CB5),
    900: Color(0xFF163BA9),
  });
  static const int _platter1PrimaryValue = 0xFF3669C9;




  //main Theme Setting
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme(),
    primarySwatch: ThemeHelper.plattet1,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: GoogleFonts.dmSerifDisplay(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),

        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black12),
  );

}
