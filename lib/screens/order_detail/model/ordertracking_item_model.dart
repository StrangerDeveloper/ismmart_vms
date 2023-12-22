import 'package:get/get.dart';

/// This class is used in the [ordertracking_item_widget] screen.
class OrdertrackingItemModel {
  OrdertrackingItemModel({
    this.orderTrackingId,
    this.orderTrackingIdNumber,
    this.pending,
    this.axelArigato,
    this.iSMMARTOriginals,
    this.sKUACamera,
    this.rsCounter,
    this.rsCounter1,
    this.xCounter,
    this.nikeCounter,
    this.iSMMARTOriginals1,
    this.sKUACamera1,
    this.rsCounter2,
    this.xCounter1,
    this.subTotal,
    this.itemsCounter,
    this.shippingFee,
    this.standardKg,
    this.promoDiscount,
    this.totalAmount,
    this.rsCounter3,
    this.rsCounter4,
    this.rsCounter5,
    this.rsCounter6,
    this.rsCounter7,
    this.id,
  }) {
    orderTrackingId = orderTrackingId ?? Rx("Order tracking id");
    orderTrackingIdNumber = orderTrackingIdNumber ?? Rx("753205721");
    pending = pending ?? Rx("Pending");
    axelArigato = axelArigato ?? Rx("Axel Arigato");
    iSMMARTOriginals = iSMMARTOriginals ?? Rx("ISMMART Originals");
    sKUACamera = sKUACamera ?? Rx("SKU: A9Camera");
    rsCounter = rsCounter ?? Rx("Rs. 10,000.00");
    rsCounter1 = rsCounter1 ?? Rx("Rs. 5,000");
    xCounter = xCounter ?? Rx("x 2");
    nikeCounter = nikeCounter ?? Rx("Nike 360");
    iSMMARTOriginals1 = iSMMARTOriginals1 ?? Rx("ISMMART Originals");
    sKUACamera1 = sKUACamera1 ?? Rx("SKU: A9Camera");
    rsCounter2 = rsCounter2 ?? Rx("Rs. 45,000");
    xCounter1 = xCounter1 ?? Rx("x 2");
    subTotal = subTotal ?? Rx("Sub Total");
    itemsCounter = itemsCounter ?? Rx("4 Items");
    shippingFee = shippingFee ?? Rx("Shipping Fee");
    standardKg = standardKg ?? Rx("Standard (1.0 kg)");
    promoDiscount = promoDiscount ?? Rx("Promo Discount");
    totalAmount = totalAmount ?? Rx("Total Amount");
    rsCounter3 = rsCounter3 ?? Rx("Rs. 9,000.00");
    rsCounter4 = rsCounter4 ?? Rx("Rs. 19,000.00");
    rsCounter5 = rsCounter5 ?? Rx("Rs. 240.00");
    rsCounter6 = rsCounter6 ?? Rx("Rs. 0");
    rsCounter7 = rsCounter7 ?? Rx("Rs. 19,240.00");
    id = id ?? Rx("");
  }

  Rx<String>? orderTrackingId;

  Rx<String>? orderTrackingIdNumber;

  Rx<String>? pending;

  Rx<String>? axelArigato;

  Rx<String>? iSMMARTOriginals;

  Rx<String>? sKUACamera;

  Rx<String>? rsCounter;

  Rx<String>? rsCounter1;

  Rx<String>? xCounter;

  Rx<String>? nikeCounter;

  Rx<String>? iSMMARTOriginals1;

  Rx<String>? sKUACamera1;

  Rx<String>? rsCounter2;

  Rx<String>? xCounter1;

  Rx<String>? subTotal;

  Rx<String>? itemsCounter;

  Rx<String>? shippingFee;

  Rx<String>? standardKg;

  Rx<String>? promoDiscount;

  Rx<String>? totalAmount;

  Rx<String>? rsCounter3;

  Rx<String>? rsCounter4;

  Rx<String>? rsCounter5;

  Rx<String>? rsCounter6;

  Rx<String>? rsCounter7;

  Rx<String>? id;
}
