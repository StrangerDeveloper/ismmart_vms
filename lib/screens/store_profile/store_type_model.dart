class StoreTypeModel {
  String? sId;
  String? name;
  bool? isSelected;

  StoreTypeModel({this.sId, this.name, this.isSelected = false});

  StoreTypeModel.fromJson(Map<String, dynamic> json) {
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

