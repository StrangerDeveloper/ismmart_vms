import 'package:flutter/cupertino.dart';

class VariantsOptionsFieldModel {
  TextEditingController? optionName;
  List<TextEditingController>? optionValues = <TextEditingController>[];

  VariantsOptionsFieldModel({this.optionName, this.optionValues});
}
