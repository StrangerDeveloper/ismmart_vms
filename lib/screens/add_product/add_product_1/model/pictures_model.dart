class PicturesModel {

  String? id;
  String? filePath;
  String? fileName;
  bool? thumbnail;
  String? url;
  String? type;

  PicturesModel({
    this.id,
    this.fileName,
    this.filePath,
    this.thumbnail,
    this.type,
    this.url
  });

  PicturesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fileName = json['fileName'];
    filePath = json['filePath'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    data['thumbnail'] = thumbnail;
    data['type'] = type;
    data['url'] = url;

    return data;
  }
}