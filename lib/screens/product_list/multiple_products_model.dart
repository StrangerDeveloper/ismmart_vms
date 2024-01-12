import 'package:ismmart_vms/screens/add_product/add_product_1/model/bottom_sheet_item_model.dart';

class MultipleProductModel {
  String? sId;
  String? name;
  String? description;
  String? slug;
  String? status;
  // List<Null>? channels;
  // List<Null>? tags;
  String? vendor;
  Store? store;
  List<Media>? media;
  List<Options>? options;
  // Seo? seo;
  BottomSheetItemModel? type;
  List<Categories>? categories;
  // List<Null>? collections;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? variants;
  int? quantity;
  int? price;

  MultipleProductModel(
      {this.sId,
        this.name,
        this.description,
        this.slug,
        this.status,
        // this.channels,
        // this.tags,
        this.vendor,
        this.store,
        this.media,
        this.options,
        // this.seo,
        this.type,
        this.categories,
        // this.collections,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.variants,
        this.quantity,
        this.price});

  MultipleProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    status = json['status'];
    // if (json['channels'] != null) {
    //   channels = <Null>[];
    //   json['channels'].forEach((v) {
    //     channels!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(Null.fromJson(v));
    //   });
    // }
    vendor = json['vendor'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    // seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    type = json['type'] != null ? BottomSheetItemModel.fromJson(json['type']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    // if (json['collections'] != null) {
    //   collections = <Null>[];
    //   json['collections'].forEach((v) {
    //     collections!.add(Null.fromJson(v));
    //   });
    // }
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    variants = json['variants'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['status'] = status;
    // if (channels != null) {
    //   data['channels'] = channels!.map((v) => v.toJson()).toList();
    // }
    // if (tags != null) {
    //   data['tags'] = tags!.map((v) => v.toJson()).toList();
    // }
    data['vendor'] = vendor;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    // if (seo != null) {
    //   data['seo'] = seo!.toJson();
    // }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    // if (collections != null) {
    //   data['collections'] = collections!.map((v) => v.toJson()).toList();
    // }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['variants'] = variants;
    // if (variants != null) {
    //   data['variants'] = variants!.map((v) => v.toJson()).toList();
    // }
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class Categories {
  String? id;
  String? name;

  Categories({
    this.id,
    this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class Store {
  String? sId;
  String? slug;
  String? logo;
  String? name;

  Store({this.sId, this.slug, this.logo, this.name});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    slug = json['slug'];
    logo = json['logo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['slug'] = slug;
    data['logo'] = logo;
    data['name'] = name;
    return data;
  }
}

class Media {
  String? url;
  bool? thumbnail;
  String? type;
  String? sId;

  Media({this.url, this.thumbnail, this.type, this.sId});

  Media.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumbnail'] = thumbnail;
    data['type'] = type;
    data['_id'] = sId;
    return data;
  }
}

class Options {
  String? name;
  List<String>? values;
  String? sId;

  Options({this.name, this.values, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['values'] = values;
    data['_id'] = sId;
    return data;
  }
}

// class Seo {
//   List<Null>? keywords;
//
//   Seo({this.keywords});
//
//   Seo.fromJson(Map<String, dynamic> json) {
//     if (json['keywords'] != null) {
//       keywords = <Null>[];
//       json['keywords'].forEach((v) {
//         keywords!.add(Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (keywords != null) {
//       data['keywords'] = keywords!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Variants {
  String? sId;
  String? name;
  String? slug;
  String? weight;
  Dimensions? dimensions;
  List<String>? options;
  String? vendor;
  String? store;
  String? product;
  bool? deleted;
  // List<Null>? media;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Variants(
      {this.sId,
        this.name,
        this.slug,
        this.weight,
        this.dimensions,
        this.options,
        this.vendor,
        this.store,
        this.product,
        this.deleted,
        // this.media,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Variants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    weight = json['weight'].toString();
    dimensions = json['dimensions'] != null
        ? Dimensions.fromJson(json['dimensions'])
        : null;
    options = json['options'].cast<String>();
    vendor = json['vendor'];
    store = json['store'];
    product = json['product'];
    deleted = json['deleted'];
    // if (json['media'] != null) {
    //   media = <Null>[];
    //   json['media'].forEach((v) {
    //     media!.add(Null.fromJson(v));
    //   });
    // }
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['weight'] = weight;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['options'] = options;
    data['vendor'] = vendor;
    data['store'] = store;
    data['product'] = product;
    data['deleted'] = deleted;
    // if (media != null) {
    //   data['media'] = media!.map((v) => v.toJson()).toList();
    // }
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Dimensions {
  int? width;
  int? length;
  int? height;

  Dimensions({this.width, this.length, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    length = json['length'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['length'] = length;
    data['height'] = height;
    return data;
  }
}