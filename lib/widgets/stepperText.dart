import 'package:flutter/material.dart';

import '../helper/theme_helper.dart';

Widget stepperText() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 25),
    child: RichText(
      overflow: TextOverflow.ellipsis,
      text: const TextSpan(
        style: TextStyle(
          color: ThemeHelper.blue1,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: "  /  ",
            style: TextStyle(
              color: ThemeHelper.grey6,
            ),
          ),
          TextSpan(
            text: "Product & Pricing ",
            style: TextStyle(
              color: ThemeHelper.grey2,
            ),
          ),
          TextSpan(
            text: "  /  ",
            style: TextStyle(
              color: ThemeHelper.grey6,
            ),
          ),
          TextSpan(
            text: "Variant Setting",
            style: TextStyle(
              color: ThemeHelper.grey2,
            ),
          ),
          TextSpan(
            text: "  /  ",
            style: TextStyle(
              color: ThemeHelper.grey6,
            ),
          ),
          TextSpan(
            text: "Shipping",
          ),
        ],
      ),
    ),
  );
}
