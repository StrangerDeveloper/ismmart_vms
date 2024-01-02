class CollectionModel {
  String? sId;
  String? name;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CollectionModel(
      {this.sId,
      this.name,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CollectionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
