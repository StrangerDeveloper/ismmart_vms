class OrderModel {
  final List<OrderItem>? items;
  final int? page;
  final int? limit;
  final int? pages;
  final int? total;

  OrderModel({
    this.items,
    this.page,
    this.limit,
    this.pages,
    this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
  final Address? address;
  final List<OrderProductItem>? items;
  final OrderDetails? orderDetails;
  final Totals? totals;
  final String? paymentType;
  final ShippingMethod? shippingMethod;
  final List<Timeline>? timeline;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderItem({
    this.id,
    this.customer,
    this.address,
    this.items,
    this.orderDetails,
    this.totals,
    this.paymentType,
    this.shippingMethod,
    this.timeline,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        items: json["items"] == null
            ? []
            : List<OrderProductItem>.from(
                json["items"]!.map((x) => OrderProductItem.fromJson(x))),
        orderDetails: json["orderDetails"] == null
            ? null
            : OrderDetails.fromJson(json["orderDetails"]),
        totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
        paymentType: json["paymentType"],
        shippingMethod: json["shippingMethod"] == null
            ? null
            : ShippingMethod.fromJson(json["shippingMethod"]),
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer": customer?.toJson(),
        "address": address?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "orderDetails": orderDetails?.toJson(),
        "totals": totals?.toJson(),
        "paymentType": paymentType,
        "shippingMethod": shippingMethod?.toJson(),
        "timeline": timeline == null
            ? []
            : List<dynamic>.from(timeline!.map((x) => x.toJson())),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Address {
  final BillingShipping? shipping;
  final BillingShipping? billing;

  Address({
    this.shipping,
    this.billing,
  });
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        shipping: json["shipping"] == null
            ? null
            : BillingShipping.fromJson(json["shipping"]),
        billing: json["billing"] == null
            ? null
            : BillingShipping.fromJson(json["billing"]),
      );

  Map<String, dynamic> toJson() => {
        "shipping": shipping?.toJson(),
        "billing": billing?.toJson(),
      };
}

class BillingShipping {
  final String? city;
  final String? country;
  final String? address;

  BillingShipping({
    this.city,
    this.country,
    this.address,
  });

  factory BillingShipping.fromJson(Map<String, dynamic> json) =>
      BillingShipping(
        city: json["city"],
        country: json["country"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "address": address,
      };
}

class Customer {
  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final String? gender;
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
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        gender: json["gender"],
        cnic: json["cnic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "phone": phone,
        "gender": gender,
        "cnic": cnic,
      };
}

class OrderProductItem {
  final String? id;
  final String? product;
  final String? vendor;
  final String? name;
  final List<String>? media;
  final int? qty;
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
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final List<dynamic>? assignedRider;

  OrderProductItem({
    this.id,
    this.product,
    this.vendor,
    this.name,
    this.media,
    this.qty,
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
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.assignedRider,
  });

  factory OrderProductItem.fromJson(Map<String, dynamic> json) =>
      OrderProductItem(
        id: json["_id"],
        product: json["product"],
        vendor: json["vendor"],
        name: json["name"],
        media: json["media"] == null
            ? []
            : List<String>.from(json["media"]!.map((x) => x)),
        qty: json["qty"],
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
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        assignedRider: json["assignedRider"] == null
            ? []
            : List<dynamic>.from(json["assignedRider"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
        "vendor": vendor,
        "name": name,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "qty": qty,
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
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "assignedRider": assignedRider == null
            ? []
            : List<dynamic>.from(assignedRider!.map((x) => x)),
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

class Timeline {
  final String? status;
  final DateTime? dated;
  final String? user;
  final String? id;

  Timeline({
    this.status,
    this.dated,
    this.user,
    this.id,
  });
  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        status: json["status"],
        dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
        user: json["user"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "dated": dated?.toIso8601String(),
        "user": user,
        "_id": id,
      };
}
