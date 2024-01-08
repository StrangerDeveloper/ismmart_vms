class BottomSheetItemModel {
  String? id;
  String? name;
  int? oldIndex;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  BottomSheetItemModel({
    this.id,
    this.name,
    this.oldIndex,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory BottomSheetItemModel.fromJson(Map<String, dynamic> json) => BottomSheetItemModel(
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
