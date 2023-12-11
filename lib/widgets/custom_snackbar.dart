

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/theme_helper.dart';

class CustomSnackBar {
  static showSnackBar({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: ThemeHelper.primary,
        message: message,
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        // mainButton: backButton(),
      ),
    );
  }

  // static Widget backButton() {
  //   return InkWell(
  //     onTap: () {
  //       Get.back();
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.only(left: 15, top: 5, right: 7),
  //       height: 30,
  //       width: 30,
  //       decoration: BoxDecoration(
  //         color: Colors.black.withOpacity(0.4),
  //         borderRadius: BorderRadius.circular(33),
  //       ),
  //       child: const Icon(
  //         Icons.close,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }


  // static displaySnackBar(String title, message, {SnackPosition? position}) {
  //   var bgColor = kLimeGreenColor;
  //   var icon = Icons.gpp_good_sharp;
  //   var titleNew = title;
  //
  //   if (title.toLowerCase().contains('error')) {
  //     titleNew = "Oops!";
  //     bgColor = kRedColor;
  //     icon = Icons.error_outline;
  //   }
  //
  //   var messageNew = message;
  //   if (message.toString().toLowerCase().contains(SESSION_EXPIRED)) {
  //     messageNew =
  //     "Your session has expired. For security reasons, please sign in again to continue.";
  //   } else if (message.toString().toLowerCase().contains(INVALID_USER)) {
  //     messageNew =
  //     "We're sorry, but we couldn't recognize that user. Please double-check and try again, or contact support for assistance.";
  //   }
  //
  //   Get.snackbar(titleNew.capitalizeFirst!.toString(), messageNew.toString(),
  //       duration: Duration(milliseconds: 1000),
  //       snackPosition: position ?? SnackPosition.TOP,
  //       backgroundColor: bgColor,
  //       icon: Icon(
  //         icon,
  //         color: Colors.white,
  //       ),
  //       colorText: Colors.white);
  // }
}
