class CountriesModel {
  String? sId;
  String? name;
  num? latitude;
  num? longitude;
  String? code;

  CountriesModel(
      {this.sId, this.name, this.latitude, this.longitude, this.code});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['code'] = this.code;
    return data;
  }
}
