class LocationInventoryModel {
  String? sId;
  int? quantity;
  int? price;
  String? sku;
  String? barcode;
  Shipping? shipping;
  String? vendor;
  String? product;
  String? variant;
  Location? location;
  bool? deleted;
  int? iV;
  String? createdAt;
  String? updatedAt;

  LocationInventoryModel(
      {this.sId,
        this.quantity,
        this.price,
        this.sku,
        this.barcode,
        this.shipping,
        this.vendor,
        this.product,
        this.variant,
        this.location,
        this.deleted,
        this.iV,
        this.createdAt,
        this.updatedAt});

  LocationInventoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    price = json['price'];
    sku = json['sku'];
    barcode = json['barcode'];
    shipping = json['shipping'] != null
        ? Shipping.fromJson(json['shipping'])
        : null;
    vendor = json['vendor'];
    product = json['product'];
    variant = json['variant'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    deleted = json['deleted'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['sku'] = sku;
    data['barcode'] = barcode;
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    data['vendor'] = vendor;
    data['product'] = product;
    data['variant'] = variant;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['deleted'] = deleted;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Shipping {
  String? overwrite;
  int? rate;

  Shipping({this.overwrite, this.rate});

  Shipping.fromJson(Map<String, dynamic> json) {
    overwrite = json['overwrite'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overwrite'] = overwrite;
    data['rate'] = rate;
    return data;
  }
}

class Location {
  String? sId;
  String? address;
  String? city;
  String? country;

  Location({this.sId, this.address, this.city, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    return data;
  }
}