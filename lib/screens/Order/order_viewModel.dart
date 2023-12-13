import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/model/order_model.dart';

class OrderViewModel extends GetxController {
  var order = Order(
    orderId: 1,
    amount: 0.0,
    customerName: '',
    customerPhone: '',
    customerEmail: '',
    date: DateTime.now(),
    paymentStatus: '',
    fulfillmentStatus: '',
    deliveryStatus: '',
    deliveryMethod: '',
    channel: '',
    market: '',
    items: [],
    numberOfProducts: 0,
    timeline: [],
    returnItems: [],
    refundItems: [],
  ).obs;

  Future<void> fetchOrderDetails(int orderId) async {
    try {
      // will Fetch order details from our API service by passing the orderId
      // will Replace this with our actual API call to fetch order details
      // Example:
      // final response = await ourApiService.getOrderDetails(orderId);

      // For demonstration, using hardcoded data (will replace with API call later)
      final response =
          hardcodedOrderData(); // will replace with our API call later

      // Parse the response data and update the order value
      order.value = Order(
        orderId: response['orderId'],
        amount: response['amount'],
        customerName: response['customerName'],
        customerPhone: response['customerPhone'],
        customerEmail: response['customerEmail'],
        date: response['date'],
        paymentStatus: response['paymentStatus'],
        fulfillmentStatus: response['fulfillmentStatus'],
        deliveryStatus: response['deliveryStatus'],
        deliveryMethod: response['deliveryMethod'],
        channel: response['channel'],
        market: response['market'],
        items: response['items'], // Update with parsed item data
        numberOfProducts: response['numberOfProducts'],
        timeline: response['timeline'], // Update with parsed timeline data
        returnItems: response['returnItems'], // Update with parsed return items
        refundItems: response['refundItems'], // Update with parsed refund items
      );
    } catch (e) {
      debugPrint('Error fetching order details: $e');
    }
  }

  // Hardcoded order data for demonstration (will replace this with API call)
  Map<String, dynamic> hardcodedOrderData() {
    return {
      'orderId': 1001,
      'amount': 908.0,
      'customerName': 'John Doe',
      'customerPhone': '0123456789',
      'customerEmail': 'test@gmail.com',
      'date': DateTime.now(),
      'paymentStatus': 'paid',
      'fulfillmentStatus': 'fulfilled',
      'deliveryStatus': 'delivered',
      'deliveryMethod': 'delivery',
      'channel': 'online',
      'market': 'amazon',
      'items': [
        {
          'itemId': 1,
          'name': 'Product 1',
          // ... Other item details
        },
        {
          'itemId': 2,
          'name': 'Product 2',
          // ... Other item details
        },
      ],
      'numberOfProducts': 2,
      'timeline': [],
      'returnItems': [],
      'refundItems': [],
    };
  }
}
