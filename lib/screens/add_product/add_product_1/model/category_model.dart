class CategoryModel {
  List<CategoryItem>? items;
  int? page;
  int? limit;
  int? pages;
  int? total;

  CategoryModel({
    this.items,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        items: json["items"] == null
            ? []
            : List<CategoryItem>.from(json["items"]!.map((x) => CategoryItem.fromJson(x))),
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

class CategoryItem {
  String? id;
    String? name;
    bool? deleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    CategoryItem({
        this.id,
        this.name,
        this.deleted,
        this.createdAt,
        this.updatedAt,
     
    });
    factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["_id"],
        name: json["name"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      
    };
}


