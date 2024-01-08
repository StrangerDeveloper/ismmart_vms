class LocationInventoryModel {
  String? sId;
  String? vendor;
  String? name;
  String? status;
  String? address;
  City? city;
  City? country;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LocationInventoryModel({
    this.sId,
    this.vendor,
    this.name,
    this.status,
    this.address,
    this.city,
    this.country,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.iV
  });

  LocationInventoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendor = json['vendor'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    country =
    json['country'] != null ? City.fromJson(json['country']) : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['vendor'] = vendor;
    data['name'] = name;
    data['status'] = status;
    data['address'] = address;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class City {
  String? sId;
  String? name;

  City({this.sId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}