import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const CustomText({
    Key? key,
    required this.title,
    this.style,
    this.size,
    this.color,
    this.textAlign,
    this.weight,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
