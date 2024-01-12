import '../screens/Order/order_listing/model/orderModel.dart';

class VariantSelectionModel {
  String? id;
  String? variantName;
  double? weight;
  Dimensions? dimensions;
  bool? variantSelected;
  List<LocationInventory>? locationInventory;
  int totalInventoryQuantityValue;

  VariantSelectionModel({
    this.id,
    this.variantSelected,
    this.totalInventoryQuantityValue = 0,
    this.variantName,
    this.locationInventory,
    this.weight,
    this.dimensions,
  });
}

class LocationInventory{
  String? id;
  String? locationName;
  String? sku;
  String? barcode;
  int? price;
  int? quantity;

  LocationInventory({
    this.id,
    this.locationName,
    this.price,
    this.quantity,
    this.barcode,
    this.sku
  });
}