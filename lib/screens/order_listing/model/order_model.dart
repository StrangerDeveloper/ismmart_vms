import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/model/gridItem_model.dart';

class Order {
  int orderId;
  double amount;
  String customerName;
  String customerPhone;
  String customerEmail;
  int numberOfProducts;
  DateTime date;
  String paymentStatus;
  String fulfillmentStatus;
  String deliveryStatus;
  String deliveryMethod;
  String channel;
  String market;
  List<Item> items;
  List<TimelineItem> timeline;
  List<ReturnItem> returnItems;
  List<RefundItem> refundItems;

  Order({
    required this.orderId,
    required this.amount,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.numberOfProducts,
    required this.date,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.deliveryStatus,
    required this.deliveryMethod,
    required this.channel,
    required this.market,
    required this.items,
    required this.timeline,
    required this.returnItems,
    required this.refundItems,
  });
}

class Item {
  int itemId;
  String name;
  List<String> media; // Images/Videos URLs
  int quantity;
  double price;
  double discountedPrice;
  double discount;
  String variantName;
  double customShipping;
  double customTax;
  Vendor vendor;
  String type;
  Category category;
  String sku;
  String barcode;
  double weight;
  Dimensions dimensions;

  Item({
    required this.itemId,
    required this.name,
    required this.media,
    required this.quantity,
    required this.price,
    required this.discountedPrice,
    required this.discount,
    required this.variantName,
    required this.customShipping,
    required this.customTax,
    required this.vendor,
    required this.type,
    required this.category,
    required this.sku,
    required this.barcode,
    required this.weight,
    required this.dimensions,
  });
}

class Vendor {
  int vendorId;
  String vendorName;

  Vendor({
    required this.vendorId,
    required this.vendorName,
    required String name,
  });
}

enum Category {
  electronics,
  fashion,
  grocery,
  beauty,
  furniture,
  medicine,
  books,
  other,
}

class Dimensions {
  double width;
  double height;
  double length;

  Dimensions({
    required this.width,
    required this.height,
    required this.length,
  });
}

class TimelineItem {
  String status;
  DateTime dated;
  User user;

  TimelineItem({
    required this.status,
    required this.dated,
    required this.user,
  });
}

class User {
  int userId;
  String userName;

  User({
    required this.userId,
    required this.userName,
  });
}

class ReturnItem {
  int returnId;
  String name;
  List<String> media;
  int quantityReturned;
  double price;
  double discountedPrice;
  double discount;
  String variantName;
  double customShipping;
  double customTax;
  Vendor vendor;
  String type;
  Category category;
  String sku;
  String barcode;
  double weight;
  Dimensions dimensions;

  ReturnItem({
    required this.returnId,
    required this.name,
    required this.media,
    required this.quantityReturned,
    required this.price,
    required this.discountedPrice,
    required this.discount,
    required this.variantName,
    required this.customShipping,
    required this.customTax,
    required this.vendor,
    required this.type,
    required this.category,
    required this.sku,
    required this.barcode,
    required this.weight,
    required this.dimensions,
  });
}

class RefundItem {
  int refundId;
  String name;
  List<String> media;
  int quantityRefunded;
  double price;
  double discountedPrice;
  double discount;
  String variantName;
  double customShipping;
  double customTax;
  Vendor vendor;
  String type;
  Category category;
  String sku;
  String barcode;
  double weight;
  Dimensions dimensions;

  RefundItem({
    required this.refundId,
    required this.name,
    required this.media,
    required this.quantityRefunded,
    required this.price,
    required this.discountedPrice,
    required this.discount,
    required this.variantName,
    required this.customShipping,
    required this.customTax,
    required this.vendor,
    required this.type,
    required this.category,
    required this.sku,
    required this.barcode,
    required this.weight,
    required this.dimensions,
  });
}

class OrdersModel {
  Rx<List<GriditemsItemModel>> griditemsItemList = Rx(
    [
      GriditemsItemModel(
          iconShapesText: "3".obs, newOrdersText: "New Orders".obs),
      GriditemsItemModel(
          iconShapesText: "9".obs, newOrdersText: "Confirmed".obs),
      GriditemsItemModel(
          iconShapesText: "1".obs, newOrdersText: "Ready to Ship".obs),
      GriditemsItemModel(iconShapesText: "0".obs, newOrdersText: "Pickups".obs),
      GriditemsItemModel(
          iconShapesText: "8".obs, newOrdersText: "In Transit".obs),
      GriditemsItemModel(
          iconShapesText: "0".obs, newOrdersText: "Exceptions".obs),
      GriditemsItemModel(
          iconShapesText: "113".obs, newOrdersText: "Delivered".obs),
      GriditemsItemModel(iconShapesText: "23".obs, newOrdersText: "RTO".obs),
      GriditemsItemModel(
          iconShapesText: "0".obs, newOrdersText: "Returned".obs),
      GriditemsItemModel(iconShapesText: "0".obs, newOrdersText: "Held".obs),
      GriditemsItemModel(
          iconShapesText: "506".obs, newOrdersText: "Cancelled".obs),
      GriditemsItemModel(
          iconShapesText: "663".obs, newOrdersText: "All Orders".obs)
    ],
  );
}
