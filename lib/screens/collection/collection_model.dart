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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
