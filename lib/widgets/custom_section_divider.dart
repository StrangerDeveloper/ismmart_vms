import 'package:flutter/material.dart';

class CustomSectionDivier extends StatelessWidget {
  const CustomSectionDivier({required this.text, super.key});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text!,
            //style: newFontStyle4,
          ),
        ),
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
