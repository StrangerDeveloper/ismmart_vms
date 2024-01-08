import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/theme_helper.dart';

Widget stepperText(int index) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 25),
    child: RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: const TextStyle(
          color: ThemeHelper.blue1,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "Product Details",
            style: TextStyle(
              color: index == 1 ? newColorBlue : ThemeHelper.grey2,
            ),
          ),
          const TextSpan(
            text: "  /  ",
            style: TextStyle(
              color: ThemeHelper.grey6,
            ),
          ),
          TextSpan(
            text: "Variant Setting",
            style: TextStyle(
              color: index == 2 ? newColorBlue : ThemeHelper.grey2,
            ),
          ),
          const TextSpan(
            text: "  /  ",
            style: TextStyle(
              color: ThemeHelper.grey6,
            ),
          ),
          TextSpan(
            text: "Shipping",
            style: TextStyle(
              color: index == 3 ? newColorBlue : ThemeHelper.grey2,
            )
          ),
        ],
      ),
    ),
  );
}
