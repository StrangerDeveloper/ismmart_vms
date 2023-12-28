class LocationModel {
  String? sId;
  String? vendor;
  String? store;
  String? address;
  City? city;
  City? country;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? name;
  String? status;
  String? phone;

  LocationModel(
      {this.sId,
      this.vendor,
      this.store,
      this.address,
      this.city,
      this.country,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.name,
      this.status,
      this.phone});

  LocationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendor = json['vendor'];
    store = json['store'];
    address = json['address'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    country =
        json['country'] != null ? new City.fromJson(json['country']) : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    name = json['name'];
    status = json['status'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vendor'] = this.vendor;
    data['store'] = this.store;
    data['address'] = this.address;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['name'] = this.name;
    data['status'] = this.status;
    data['phone'] = this.phone;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
