import 'package:flutter/cupertino.dart';

class VariantsOptionsFieldModel {
  String? id;
  TextEditingController? optionName;
  List<TextEditingController>? optionValues = <TextEditingController>[];

  VariantsOptionsFieldModel({this.id, this.optionName, this.optionValues});
}
