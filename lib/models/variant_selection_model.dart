class VariantSelectionModel {
  String? variantName;
  bool? variantSelected;
  double? variantValue;
  int inventoryQuantityValue;

  VariantSelectionModel({this.variantSelected, this.inventoryQuantityValue = 0, this.variantName, this.variantValue});
}
