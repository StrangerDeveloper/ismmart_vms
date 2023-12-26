import 'package:flutter/material.dart';
import 'package:ismmart_vms/helper/resourses/app_colors.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(
        color: black900,
      );
  static BoxDecoration get fillBlue => BoxDecoration(
        color: blue5002,
      );
  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: blue50,
      );
  static BoxDecoration get fillBlue5001 => BoxDecoration(
        color: blue5001,
      );
  static BoxDecoration get fillCyan => BoxDecoration(
        color: cyan50,
      );
  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: deepOrange200,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: gray20001,
      );
  static BoxDecoration get fillGray100 => BoxDecoration(
        color: gray100,
      );
  static BoxDecoration get fillGray10001 => BoxDecoration(
        color: gray10001,
      );
  static BoxDecoration get fillGray10002 => BoxDecoration(
        color: gray10002,
      );
  static BoxDecoration get fillGray10003 => BoxDecoration(
        color: gray10003,
      );
  static BoxDecoration get fillGray50 => BoxDecoration(
        color: gray50,
      );
  static BoxDecoration get fillGray5001 => BoxDecoration(
        color: gray5001,
      );
  static BoxDecoration get fillOrange => BoxDecoration(
        color: orange50,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: red50,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: teal100,
      );
  static BoxDecoration get fillTeal10001 => BoxDecoration(
        color: teal10001,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: whiteA700,
      );
  static BoxDecoration get fillYellow => BoxDecoration(
        color: yellow200,
      );
  static BoxDecoration get fillYellow20001 => BoxDecoration(
        color: yellow20001,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: primary,
        boxShadow: [
          BoxShadow(
            color: black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900 => const BoxDecoration();
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: gray5001,
        boxShadow: [
          BoxShadow(
            color: black900.withOpacity(0.05),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: whiteA700,
        border: Border(
          top: BorderSide(
            color: blueGray30001.withOpacity(0.5),
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        color: gray5001,
        border: Border.all(
          color: blueGray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBluegray30001 => BoxDecoration(
        color: whiteA700,
        border: Border(
          top: BorderSide(
            color: blueGray30001.withOpacity(0.5),
            width: 1.h,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBluegray300011 => BoxDecoration(
        color: whiteA700,
        border: Border(
          top: BorderSide(
            color: blueGray30001.withOpacity(0.5),
            width: 1.h,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: gray200,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray200 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: gray200,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray20001 => BoxDecoration(
        border: Border.all(
          color: gray20001,
          width: 1.h,
          strokeAlign: strokeAlignCenter,
        ),
      );
  static BoxDecoration get outlineGray200011 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: gray20001,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray200012 => BoxDecoration(
        border: Border.all(
          color: gray20001,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray200013 => BoxDecoration(
        border: Border.all(
          color: gray20001,
          width: 1.h,
          strokeAlign: strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineGray200014 => BoxDecoration(
        color: gray5001,
        border: Border.all(
          color: gray20001,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: gray5001,
        border: Border.all(
          color: primary,
          width: 1.h,
        ),
      );

  // Shadow decorations
  static BoxDecoration get shadow => BoxDecoration(
        color: whiteA700,
        boxShadow: [
          BoxShadow(
            color: black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder16 => BorderRadius.circular(
        16.h,
      );

  // Custom borders
  static BorderRadius get customBorderBL6 => BorderRadius.vertical(
        bottom: Radius.circular(6.h),
      );
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );
  static BorderRadius get customBorderTL8 => BorderRadius.vertical(
        top: Radius.circular(8.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder28 => BorderRadius.circular(
        28.h,
      );
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
