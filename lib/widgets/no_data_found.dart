import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../helper/constants.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound(
      {super.key, this.text, this.maxLines, this.textAlign, this.fontSize});

  final String? text;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        title: text ?? noDataFound.tr,
        maxLines: maxLines ?? 4,
        textAlign: textAlign ?? TextAlign.center,
        style: headline3,
        weight: FontWeight.w600,
        size: fontSize ?? 17,
      ),
    );
  }
}
