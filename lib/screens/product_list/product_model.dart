class ProductModel {
  List<ProductsItem>? items;
  int? page;
  int? limit;
  int? pages;
  int? total;

  ProductModel({
    this.items,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        items: json["items"] == null
            ? []
            : List<ProductsItem>.from(json["items"]!.map((x) => ProductsItem.fromJson(x))),
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

class ProductsItem {
String? id;
    String? name;
    String? slug;
    String? status;
    List<dynamic>? channels;
    List<dynamic>? tags;
    String? vendor;
    Store? store;
    List<Media>? media;
    List<Option>? options;
    Seo? seo;
    String? type;
    List<Category>? categories;
    List<dynamic>? collections;
    bool? deleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Variant>? variants;

    ProductsItem({
        this.id,
        this.name,
        this.slug,
        this.status,
        this.channels,
        this.tags,
        this.vendor,
        this.store,
        this.media,
        this.options,
        this.seo,
        this.type,
        this.categories,
        this.collections,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.variants,
    });

    factory ProductsItem.fromJson(Map<String, dynamic> json) => ProductsItem(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        channels: json["channels"] == null ? [] : List<dynamic>.from(json["channels"]!.map((x) => x)),
        tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
        vendor: json["vendor"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
        seo: json["seo"] == null ? null : Seo.fromJson(json["seo"]),
        type: json["type"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        collections: json["collections"] == null ? [] : List<dynamic>.from(json["collections"]!.map((x) => x)),
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "channels": channels == null ? [] : List<dynamic>.from(channels!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "vendor": vendor,
        "store": store?.toJson(),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "seo": seo?.toJson(),
        "type": type,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x)),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
    };
}

class Category {
    String? id;
    String? name;

    Category({
        this.id,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class Media {
    String? url;
    bool? thumbnail;
    String? type;
    String? id;

    Media({
        this.url,
        this.thumbnail,
        this.type,
        this.id,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        url: json["url"],
        thumbnail: json["thumbnail"],
        type: json["type"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "thumbnail": thumbnail,
        "type": type,
        "_id": id,
    };
}

class Option {
    String? name;
    List<String>? values;
    String? id;

    Option({
        this.name,
        this.values,
        this.id,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        values: json["values"] == null ? [] : List<String>.from(json["values"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
        "_id": id,
    };
}

class Seo {
    List<dynamic>? keywords;

    Seo({
        this.keywords,
    });

    factory Seo.fromJson(Map<String, dynamic> json) => Seo(
        keywords: json["keywords"] == null ? [] : List<dynamic>.from(json["keywords"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
    };
}

class Store {
    String? id;
    String? slug;
    String? logo;

    Store({
        this.id,
        this.slug,
        this.logo,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        slug: json["slug"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "slug": slug,
        "logo": logo,
    };
}

class Variant {
    String? id;
    String? name;
    String? slug;
    String? sku;
    String? barcode;
    int? weight;
    Dimensions? dimensions;
    List<String>? options;
    String? vendor;
    String? store;
    String? product;
    bool? deleted;
    List<dynamic>? media;
    int? v;
    DateTime? createdAt;
    DateTime? updatedAt;

    Variant({
        this.id,
        this.name,
        this.slug,
        this.sku,
        this.barcode,
        this.weight,
        this.dimensions,
        this.options,
        this.vendor,
        this.store,
        this.product,
        this.deleted,
        this.media,
        this.v,
        this.createdAt,
        this.updatedAt,
    });

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        barcode: json["barcode"],
        weight: json["weight"],
        dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"]),
        options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
        vendor: json["vendor"],
        store: json["store"],
        product: json["product"],
        deleted: json["deleted"],
        media: json["media"] == null ? [] : List<dynamic>.from(json["media"]!.map((x) => x)),
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "barcode": barcode,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "vendor": vendor,
        "store": store,
        "product": product,
        "deleted": deleted,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Dimensions {
    int? width;
    int? length;
    int? height;

    Dimensions({
        this.width,
        this.length,
        this.height,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"],
        length: json["length"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "length": length,
        "height": height,
    };
}



