import 'locations_model.dart';

class ProductVariantModel {
  String? name;
  int? id;
  int? productId;
  String? sku;
  String? barcode;
  double? cutPrice;
  double? weight;
  Dimension? dimension;
  List<Stock>? stock;

  ProductVariantModel({
    this.id,
    this.productId,
    this.barcode,
    this.sku,
    this.name,
    this.cutPrice,
    this.weight,
    this.dimension,
    this.stock
  });

  ProductVariantModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productId = json['productId'];
    barcode = json['barcode'];
    sku = json['sku'];
    name = json['name'];
    cutPrice = json['cutPrice'];
    weight = json['weight'];
    if(json['dimension'] != null) {
      dimension = Dimension.fromJson(json['dimension']);
    }
    if (json['stock'] != null) {
      stock = <Stock>[];
      json['stock'].forEach((v) {
        stock!.add(Stock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['_id'] = id;
    data['productId'] = productId;
    data['barcode'] = barcode;
    data['sku'] = sku;
    data['name'] = name;
    data['cutPrice'] = cutPrice;
    data['weight'] = weight;
    if(dimension != null){
      data['dimension'] = dimension!.toJson();
    }
    if (stock != null) {
      data['stock'] = stock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dimension {
  double? width;
  double? length;
  double? height;

  Dimension({
    this.length,
    this.width,
    this.height
  });

  Dimension.fromJson(Map<String,dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}