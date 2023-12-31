class Data {
  final List<OrderItem>? items;
  final int? page;
  final int? limit;
  final int? pages;
  final int? total;

  Data({
    this.items,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<OrderItem>.from(
                json["items"]!.map((x) => OrderItem.fromJson(x))),
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

class OrderItem {
  final String? id;
  final Customer? customer;
  final ContactInfo? contactInfo;
  final Address? address;
  final List<Lineitem>? lineitems;
  final OrderDetails? orderDetails;
  final String? paymentType;
  final ShippingMethod? shippingMethod;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? orderId;

  OrderItem({
    this.id,
    this.customer,
    this.contactInfo,
    this.address,
    this.lineitems,
    this.orderDetails,
    this.paymentType,
    this.shippingMethod,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.orderId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        contactInfo: json["contactInfo"] == null
            ? null
            : ContactInfo.fromJson(json["contactInfo"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        lineitems: json["lineitems"] == null
            ? []
            : List<Lineitem>.from(
                json["lineitems"]!.map((x) => Lineitem.fromJson(x))),
        orderDetails: json["orderDetails"] == null
            ? null
            : OrderDetails.fromJson(json["orderDetails"]),
        paymentType: json["paymentType"],
        shippingMethod: json["shippingMethod"] == null
            ? null
            : ShippingMethod.fromJson(json["shippingMethod"]),
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer": customer?.toJson(),
        "contactInfo": contactInfo?.toJson(),
        "address": address?.toJson(),
        "lineitems": lineitems == null
            ? []
            : List<dynamic>.from(lineitems!.map((x) => x.toJson())),
        "orderDetails": orderDetails?.toJson(),
        "paymentType": paymentType,
        "shippingMethod": shippingMethod?.toJson(),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "orderId": orderId,
      };
}

class Address {
  final Ing? shipping;
  final Ing? billing;

  Address({
    this.shipping,
    this.billing,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        shipping:
            json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
        billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
      );

  Map<String, dynamic> toJson() => {
        "shipping": shipping?.toJson(),
        "billing": billing?.toJson(),
      };
}

class Ing {
  final String? city;
  final String? country;
  final String? address;
  final String? phone;

  Ing({
    this.city,
    this.country,
    this.address,
    this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        city: json["city"],
        country: json["country"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "address": address,
        "phone": phone,
      };
}

class ContactInfo {
  final String? email;
  final String? phone;

  ContactInfo({
    this.email,
    this.phone,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
      };
}

class Customer {
  final Id? id;
  final Email? email;
  final Name? name;
  final String? phone;
  final Gender? gender;
  final String? cnic;

  Customer({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.gender,
    this.cnic,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: idValues.map[json["_id"]]!,
        email: emailValues.map[json["email"]]!,
        name: nameValues.map[json["name"]]!,
        phone: json["phone"],
        gender: genderValues.map[json["gender"]]!,
        cnic: json["cnic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "email": emailValues.reverse[email],
        "name": nameValues.reverse[name],
        "phone": phone,
        "gender": genderValues.reverse[gender],
        "cnic": cnic,
      };
}

enum Email { HMIRRAI_GMAIL_COM }

final emailValues = EnumValues({"hmirrai@gmail.com": Email.HMIRRAI_GMAIL_COM});

enum Gender { MALE }

final genderValues = EnumValues({"Male": Gender.MALE});

enum Id { THE_657809_D663534_E3_FCFB19_C72 }

final idValues = EnumValues(
    {"657809d663534e3fcfb19c72": Id.THE_657809_D663534_E3_FCFB19_C72});

enum Name { VENDOR1 }

final nameValues = EnumValues({"Vendor1": Name.VENDOR1});

class Lineitem {
  final String? id;
  final String? product;
  final Id? vendor;
  final String? name;
  final String? media;
  final int? qty;
  final int? amount;
  final Totals? totals;
  final bool? refund;
  final String? paymentStatus;
  final String? fulfilmentStatus;
  final String? deliveryStatus;
  final int? discountPercentage;
  final int? couponPercentage;
  final String? variantName;
  final int? customShipping;
  final String? type;
  final String? category;
  final String? sku;
  final String? barcode;
  final double? weight;
  final Dimensions? dimensions;
  final Customer? assignedRider;
  final List<Timeline>? timeline;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Lineitem({
    this.id,
    this.product,
    this.vendor,
    this.name,
    this.media,
    this.qty,
    this.amount,
    this.totals,
    this.refund,
    this.paymentStatus,
    this.fulfilmentStatus,
    this.deliveryStatus,
    this.discountPercentage,
    this.couponPercentage,
    this.variantName,
    this.customShipping,
    this.type,
    this.category,
    this.sku,
    this.barcode,
    this.weight,
    this.dimensions,
    this.assignedRider,
    this.timeline,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Lineitem.fromJson(Map<String, dynamic> json) => Lineitem(
        id: json["_id"],
        product: json["product"],
        vendor: idValues.map[json["vendor"]]!,
        name: json["name"],
        media: json["media"],
        qty: json["qty"],
        amount: json["amount"],
        totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
        refund: json["refund"],
        paymentStatus: json["paymentStatus"],
        fulfilmentStatus: json["fulfilmentStatus"],
        deliveryStatus: json["deliveryStatus"],
        discountPercentage: json["discountPercentage"],
        couponPercentage: json["couponPercentage"],
        variantName: json["variantName"],
        customShipping: json["customShipping"],
        type: json["type"],
        category: json["category"],
        sku: json["sku"],
        barcode: json["barcode"],
        weight: json["weight"]?.toDouble(),
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        assignedRider: json["assignedRider"] == null
            ? null
            : Customer.fromJson(json["assignedRider"]),
        timeline: json["timeline"] == null
            ? []
            : List<Timeline>.from(
                json["timeline"]!.map((x) => Timeline.fromJson(x))),
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
        "vendor": idValues.reverse[vendor],
        "name": name,
        "media": media,
        "qty": qty,
        "amount": amount,
        "totals": totals?.toJson(),
        "refund": refund,
        "paymentStatus": paymentStatus,
        "fulfilmentStatus": fulfilmentStatus,
        "deliveryStatus": deliveryStatus,
        "discountPercentage": discountPercentage,
        "couponPercentage": couponPercentage,
        "variantName": variantName,
        "customShipping": customShipping,
        "type": type,
        "category": category,
        "sku": sku,
        "barcode": barcode,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "assignedRider": assignedRider?.toJson(),
        "timeline": timeline == null
            ? []
            : List<dynamic>.from(timeline!.map((x) => x.toJson())),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Dimensions {
  final int? width;
  final int? height;
  final int? length;

  Dimensions({
    this.width,
    this.height,
    this.length,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: json["width"],
        height: json["height"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "length": length,
      };
}

class Timeline {
  final Status? status;
  final DateTime? dated;
  final Id? user;
  final String? id;

  Timeline({
    this.status,
    this.dated,
    this.user,
    this.id,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        status: statusValues.map[json["status"]]!,
        dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
        user: idValues.map[json["user"]]!,
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
        "dated": dated?.toIso8601String(),
        "user": idValues.reverse[user],
        "_id": id,
      };
}

enum Status { DELIVERED, PROCESSING, SHIPPED }

final statusValues = EnumValues({
  "Delivered": Status.DELIVERED,
  "Processing": Status.PROCESSING,
  "Shipped": Status.SHIPPED
});

class Totals {
  final int? subTotal;
  final int? tax;
  final int? shipping;
  final int? coupon;
  final int? total;

  Totals({
    this.subTotal,
    this.tax,
    this.shipping,
    this.coupon,
    this.total,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        subTotal: json["subTotal"],
        tax: json["tax"],
        shipping: json["shipping"],
        coupon: json["coupon"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "tax": tax,
        "shipping": shipping,
        "coupon": coupon,
        "total": total,
      };
}

class OrderDetails {
  final int? couponPercentage;
  final String? market;
  final String? channel;
  final String? notes;

  OrderDetails({
    this.couponPercentage,
    this.market,
    this.channel,
    this.notes,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        couponPercentage: json["couponPercentage"],
        market: json["market"],
        channel: json["channel"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "couponPercentage": couponPercentage,
        "market": market,
        "channel": channel,
        "notes": notes,
      };
}

class ShippingMethod {
  final String? id;
  final String? type;
  final int? amount;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ShippingMethod({
    this.id,
    this.type,
    this.amount,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        id: json["_id"],
        type: json["type"],
        amount: json["amount"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "amount": amount,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
