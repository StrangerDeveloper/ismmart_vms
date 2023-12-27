import 'package:flutter/material.dart';

import '../helper/theme_helper.dart';

class CustomRadioButton1 extends StatelessWidget {
  final String title;
  final String groupValue;
  final String value;
  final void Function(String) onChanged;

  const CustomRadioButton1({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onChanged(value);
            },
            child: Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: value == groupValue
                    ? Border.all(
                        width: 3.5,
                        color: ThemeHelper.blue1,
                      )
                    : Border.all(
                        color: const Color(0xFFD1D5DB),
                      ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class CustomRadioButton2 extends StatelessWidget {
  final String title;
  final String groupValue;
  final String value;
  final void Function(String) onChanged;

  const CustomRadioButton2({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onChanged(value);
            },
            child: Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: ThemeHelper.grey3,
                shape: BoxShape.circle,
                border: value == groupValue
                    ? Border.all(
                        width: 3.5,
                        color: ThemeHelper.blue1,
                      )
                    : Border.all(
                        color: const Color(0xFFD1D5DB),
                      ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: ThemeHelper.grey5,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
