class CountryModel {
  CountryModel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  int? id, countryId;
  String? name;
  String? latitude, longitude;
  DateTime? createdAt, updatedAt;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude ?? 0,
        "longitude": longitude ?? 0.0,
        "countryId": countryId ?? 0.0,
      };
}
