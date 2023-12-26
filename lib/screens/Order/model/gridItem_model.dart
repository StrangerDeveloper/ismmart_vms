import 'package:get/get.dart';

class GriditemsItemModel {
  GriditemsItemModel({
    this.iconShapesText,
    this.newOrdersText,
    this.id,
  }) {
    iconShapesText = iconShapesText ?? Rx("3");
    newOrdersText = newOrdersText ?? Rx("New Orders");
    id = id ?? Rx("");
  }

  Rx<String>? iconShapesText;

  Rx<String>? newOrdersText;

  Rx<String>? id;
}
