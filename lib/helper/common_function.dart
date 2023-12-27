import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonFunction {

  // static DateTime convertStringToDate(String stringDate) {
  //   return DateFormat("yyyy-MM-dd hh:mm:ss").parse(stringDate);
  // }
  //
  // static String convertTimeStampToTime(String stringDate) {
  //   DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(stringDate));
  //   return DateFormat("yyyy-MM-dd hh:mm a").format(date);
  // }
  //
  // static String formatDateTime(String dateTime) {
  //   DateTime date = DateFormat("yyyy-MM-ddThh:mm:ss.000000Z").parse(dateTime);
  //   return DateFormat('yyyy-MM-dd hh:mm a').format(date);
  // }

  static String convertDateFormat(String stringDate) {
    DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(stringDate).toLocal();
    String outputDate = DateFormat('dd MMM, yyyy').format(inputDate);
    return outputDate;
  }



  static void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }


  static colorConsole(String value) {
    debugPrint('\x1B[32m$value\x1B[0m');
    // Black:   \x1B[30m
    // Red:     \x1B[31m
    // Green:   \x1B[32m
    // Yellow:  \x1B[33m
    // Blue:    \x1B[34m
    // Magenta: \x1B[35m
    // Cyan:    \x1B[36m
    // White:   \x1B[37m
    // Reset:   \x1B[0m
  }

  static debugPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
