class VariantSelectionModel {
  String? variantName;
  bool? variantSelected;
  double? variantValue;
  List<LocationInventory>? locationInventory;
  int totalInventoryQuantityValue;

  VariantSelectionModel({this.variantSelected, this.totalInventoryQuantityValue = 0, this.variantName, this.variantValue, this.locationInventory});
}

class LocationInventory{
  String? id;
  String? locationName;
  double? weight;
  int? length;
  int? width;
  int? height;
  String? sku;
  String? barcode;
  double? price;
  int? quantity;

  LocationInventory({
    this.id,
    this.locationName,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.price,
    this.quantity,
    this.barcode,
    this.sku
  });
}
