class OrderModel {
  int? id;
  String? status;
  num? totalPrice, shippingPrice;
  OrderModel({this.id, this.status, this.totalPrice, this.shippingPrice});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        shippingPrice: json["shippingPrice"],
      );
}
