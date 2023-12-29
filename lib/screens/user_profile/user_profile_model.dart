class UserProfileModel {
  String? sId;
  String? email;
  String? name;
  String? phone;
  String? gender;
  String? cnic;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? deleted;
  Role? role;
  String? reason;
  String? social;
  Store? store;
  String? image;

  UserProfileModel(
      {this.sId,
        this.email,
        this.name,
        this.phone,
        this.gender,
        this.cnic,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.deleted,
        this.role,
        this.reason,
        this.social,
        this.store,
        this.image});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    cnic = json['cnic'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deleted = json['deleted'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    reason = json['reason'];
    social = json['social'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['cnic'] = this.cnic;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['deleted'] = this.deleted;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['reason'] = this.reason;
    data['social'] = this.social;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Role {
  String? sId;
  String? name;

  Role({this.sId, this.name});

  Role.fromJson(Map<String, dynamic> json) {
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

class Store {
  String? sId;
  String? vendor;
  String? slug;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? logo;
  List<Types>? types;
  String? name;

  Store(
      {this.sId,
        this.vendor,
        this.slug,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.logo,
        this.types,
        this.name});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendor = json['vendor'];
    slug = json['slug'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    logo = json['logo'];
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vendor'] = this.vendor;
    data['slug'] = this.slug;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['logo'] = this.logo;
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class Types {
  String? sId;
  String? name;

  Types({this.sId, this.name});

  Types.fromJson(Map<String, dynamic> json) {
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