import 'package:flutter/material.dart';

class CheckBoxListTile1 extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged onChanged;
  final bool value;

  const CheckBoxListTile1({
    super.key,
    required this.title,
    required this.onChanged,
    required this.isSelected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      selected: isSelected,
      value: value,
      title: Text(title),
      onChanged: onChanged,
    );
  }
}
