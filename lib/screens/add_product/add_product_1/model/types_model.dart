class TypesModel {
  List<TypesItem>? items;
  int? page;
  int? limit;
  int? pages;
  int? total;

  TypesModel({
    this.items,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory TypesModel.fromJson(Map<String, dynamic> json) => TypesModel(
        items: json["items"] == null
            ? []
            : List<TypesItem>.from(
                json["items"]!.map((x) => TypesItem.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        pages: json["pages"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "pages": pages,
        "total": total,
      };
}

class TypesItem {
  String? id;
  String? name;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  TypesItem({
    this.id,
    this.name,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory TypesItem.fromJson(Map<String, dynamic> json) => TypesItem(
        id: json["_id"],
        name: json["name"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
