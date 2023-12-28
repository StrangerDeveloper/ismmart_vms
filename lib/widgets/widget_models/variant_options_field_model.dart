import 'package:flutter/cupertino.dart';

class VariantsOptionsFieldModel {
  String? optionName;
  List<TextEditingController>? optionValues = <TextEditingController>[];

  VariantsOptionsFieldModel({this.optionName, this.optionValues});
}
