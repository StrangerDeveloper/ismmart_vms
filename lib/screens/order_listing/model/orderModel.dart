class Data {
  List<OrderItem>? items;
  int? page;
  int? limit;
  int? pages;
  int? total;

  Data({this.items, this.page, this.limit, this.pages, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(new OrderItem.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['pages'] = this.pages;
    data['total'] = this.total;
    return data;
  }
}

class OrderItem {
  String? sId;
  Customer? customer;
  ContactInfo? contactInfo;
  Address? address;
  List<Lineitem>? lineitems;
  String? status;
  OrderDetails? orderDetails;
  String? paymentType;
  ShippingMethod? shippingMethod;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  int? iV;
  OrderTotals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;

  OrderItem(
      {this.sId,
      this.customer,
      this.contactInfo,
      this.address,
      this.lineitems,
      this.status,
      this.orderDetails,
      this.paymentType,
      this.shippingMethod,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.orderId,
      this.iV,
      this.totals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    contactInfo = json['contactInfo'] != null
        ? new ContactInfo.fromJson(json['contactInfo'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['lineitems'] != null) {
      lineitems = <Lineitem>[];
      json['lineitems'].forEach((v) {
        lineitems!.add(new Lineitem.fromJson(v));
      });
    }
    status = json['status'];
    orderDetails = json['orderDetails'] != null
        ? new OrderDetails.fromJson(json['orderDetails'])
        : null;
    paymentType = json['paymentType'];
    shippingMethod = json['shippingMethod'] != null
        ? new ShippingMethod.fromJson(json['shippingMethod'])
        : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderId = json['orderId'];
    iV = json['__v'];
    totals = json['totals'] != null
        ? new OrderTotals.fromJson(json['totals'])
        : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.contactInfo != null) {
      data['contactInfo'] = this.contactInfo!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.lineitems != null) {
      data['lineitems'] = this.lineitems!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.toJson();
    }
    data['paymentType'] = this.paymentType;
    if (this.shippingMethod != null) {
      data['shippingMethod'] = this.shippingMethod!.toJson();
    }
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['orderId'] = this.orderId;
    data['__v'] = this.iV;
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    data['paymentStatus'] = this.paymentStatus;
    data['fulfilmentStatus'] = this.fulfilmentStatus;
    data['deliveryStatus'] = this.deliveryStatus;
    data['returnStatus'] = this.returnStatus;
    return data;
  }
}

class Customer {
  String? sId;
  String? email;
  String? name;
  String? phone;
  String? gender;
  String? cnic;

  Customer(
      {this.sId, this.email, this.name, this.phone, this.gender, this.cnic});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['cnic'] = this.cnic;
    return data;
  }
}

class ContactInfo {
  String? email;
  String? phone;

  ContactInfo({this.email, this.phone});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  Shipping? shipping;
  Shipping? billing;

  Address({this.shipping, this.billing});

  Address.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    billing =
        json['billing'] != null ? new Shipping.fromJson(json['billing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    return data;
  }
}

class Shipping {
  String? city;
  String? country;
  String? address;
  String? phone;

  Shipping({this.city, this.country, this.address, this.phone});

  Shipping.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}

class Lineitem {
  String? sId;
  String? product;
  String? vendor;
  String? name;
  String? media;
  int? qty;
  int? amount;
  Totals? totals;
  String? paymentStatus;
  String? fulfilmentStatus;
  String? deliveryStatus;
  String? returnStatus;
  int? discountPercentage;
  int? couponPercentage;
  String? variantName;
  int? customShipping;
  String? type;
  String? category;
  String? sku;
  String? barcode;
  double? weight;
  Dimensions? dimensions;
  Customer? assignedRider;
  List<Timeline>? timeline;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isSelected = false;

  Lineitem(
      {this.sId,
      this.product,
      this.vendor,
      this.name,
      this.media,
      this.qty,
      this.amount,
      this.totals,
      this.paymentStatus,
      this.fulfilmentStatus,
      this.deliveryStatus,
      this.returnStatus,
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
      this.iV,
      this.isSelected});

  Lineitem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['product'];
    vendor = json['vendor'];
    name = json['name'];
    media = json['media'];
    qty = json['qty'];
    amount = json['amount'];
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    paymentStatus = json['paymentStatus'];
    fulfilmentStatus = json['fulfilmentStatus'];
    deliveryStatus = json['deliveryStatus'];
    returnStatus = json['returnStatus'];
    discountPercentage = json['discountPercentage'];
    couponPercentage = json['couponPercentage'];
    variantName = json['variantName'];
    customShipping = json['customShipping'];
    type = json['type'];
    category = json['category'];
    sku = json['sku'];
    barcode = json['barcode'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    assignedRider = json['assignedRider'] != null
        ? new Customer.fromJson(json['assignedRider'])
        : null;
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(new Timeline.fromJson(v));
      });
    }
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product'] = this.product;
    data['vendor'] = this.vendor;
    data['name'] = this.name;
    data['media'] = this.media;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    data['paymentStatus'] = this.paymentStatus;
    data['fulfilmentStatus'] = this.fulfilmentStatus;
    data['deliveryStatus'] = this.deliveryStatus;
    data['returnStatus'] = this.returnStatus;
    data['discountPercentage'] = this.discountPercentage;
    data['couponPercentage'] = this.couponPercentage;
    data['variantName'] = this.variantName;
    data['customShipping'] = this.customShipping;
    data['type'] = this.type;
    data['category'] = this.category;
    data['sku'] = this.sku;
    data['barcode'] = this.barcode;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    if (this.assignedRider != null) {
      data['assignedRider'] = this.assignedRider!.toJson();
    }
    if (this.timeline != null) {
      data['timeline'] = this.timeline!.map((v) => v.toJson()).toList();
    }
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Totals {
  int? subTotal;
  int? tax;
  int? shipping;
  int? coupon;
  int? total;

  Totals({this.subTotal, this.tax, this.shipping, this.coupon, this.total});

  Totals.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    tax = json['tax'];
    shipping = json['shipping'];
    coupon = json['coupon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['tax'] = this.tax;
    data['shipping'] = this.shipping;
    data['coupon'] = this.coupon;
    data['total'] = this.total;
    return data;
  }
}

class Dimensions {
  int? width;
  int? height;
  int? length;

  Dimensions({this.width, this.height, this.length});

  Dimensions.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['length'] = this.length;
    return data;
  }
}

class Timeline {
  String? status;
  String? dated;
  String? user;
  String? sId;

  Timeline({this.status, this.dated, this.user, this.sId});

  Timeline.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dated = json['dated'];
    user = json['user'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['dated'] = this.dated;
    data['user'] = this.user;
    data['_id'] = this.sId;
    return data;
  }
}

class OrderDetails {
  int? couponPercentage;
  String? market;
  String? channel;
  String? notes;

  OrderDetails({this.couponPercentage, this.market, this.channel, this.notes});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    couponPercentage = json['couponPercentage'];
    market = json['market'];
    channel = json['channel'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponPercentage'] = this.couponPercentage;
    data['market'] = this.market;
    data['channel'] = this.channel;
    data['notes'] = this.notes;
    return data;
  }
}

class ShippingMethod {
  String? sId;
  String? type;
  int? amount;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ShippingMethod(
      {this.sId,
      this.type,
      this.amount,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    amount = json['amount'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class OrderTotals {
  int? subTotal;
  int? tax;
  int? discount;
  int? shipping;
  int? coupon;
  int? total;

  OrderTotals(
      {this.subTotal,
      this.tax,
      this.discount,
      this.shipping,
      this.coupon,
      this.total});

  OrderTotals.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    tax = json['tax'];
    discount = json['discount'];
    shipping = json['shipping'];
    coupon = json['coupon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['shipping'] = this.shipping;
    data['coupon'] = this.coupon;
    data['total'] = this.total;
    return data;
  }
}
