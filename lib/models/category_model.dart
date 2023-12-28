import 'package:ismmart_vms/models/subcategory_model.dart';

class CategoryModel {
  CategoryModel(
      {this.id,
      this.name,
      this.subCategories,
      this.updatedAt,
      this.createdAt,
      this.image,
      this.isPressed = false});

  String? name, image;
  int? id;
  List<SubCategory>? subCategories;
  DateTime? updatedAt, createdAt;
  bool? isPressed;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        subCategories: json["SubCategories"] != null
            ? List<SubCategory>.from(
                json["SubCategories"].map((x) => SubCategory.fromJson(x)))
            : [],
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "SubCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "image": image,
      };
}
