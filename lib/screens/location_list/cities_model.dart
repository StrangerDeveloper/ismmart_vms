class CitiesModel {
  String? sId;
  String? name;
  String? country;

  CitiesModel({this.sId, this.name, this.country});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['country'] = this.country;
    return data;
  }
}
