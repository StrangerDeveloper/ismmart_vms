class ProductVariantModel {
  String? name;
  int? id;
  int? productId;
  String? sku;
  String? barcode;
  double? cutPrice;
  double? weight;
  Dimension? dimension;
  // List<Locations>? locations;
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

class Stock {

  int? unavailable;
  int? onHand;
  int? available;
  int? committed;
  int? incoming;

  Stock({
    this.available,
    this.committed,
    this.incoming,
    this.onHand,
    this.unavailable
  });

  Stock.fromJson(Map<String,dynamic> json) {
    available = json['available'];
    unavailable = json['unavailable'];
    committed = json['committed'];
    onHand = json['onHand'];
    incoming = json['incoming'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['available'] = available;
    data['unavailable'] = unavailable;
    data['committed'] = committed;
    data['onHand'] = onHand;
    data['incoming'] = incoming;
    return data;
  }
}