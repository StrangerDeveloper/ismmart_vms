import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/model/order_model.dart';
// Import your API service to fetch order details

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
      // Fetch order details from your API service by passing the orderId
      // Replace this with your actual API call to fetch order details
      // Example:
      // final response = await yourApiService.getOrderDetails(orderId);

      // For demonstration, using hardcoded data (replace with API call)
      final response = hardcodedOrderData(); // Replace with your API call

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
      // Handle error
      print('Error fetching order details: $e');
    }
  }

  // Hardcoded order data for demonstration (Replace this with API call)
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














// // Import necessary packages and files
// import 'package:get/get.dart';
// import 'package:ismmart_vms/screens/Order/model/order_model.dart';
// // Your API service to fetch order details

// class OrderViewModel extends GetxController {
//   var order = Order(
//     orderId: 0,
//     amount: 0.0,
//     customerName: '',
//     customerPhone: '',
//     customerEmail: '',
//     date: DateTime.now(),
//     paymentStatus: '',
//     fulfillmentStatus: '',
//     deliveryStatus: '',
//     deliveryMethod: '',
//     channel: '',
//     market: '',
//     items: [],
//     numberOfProducts: 0,
//     timeline: [],
//     returnItems: [],
//     refundItems: [],
//   ).obs;

//   void fetchOrderDetails(int orderId) async {
//     // Fetch order details from API service

//     // used hard coded data for now as a boiler plate

//     order.value = Order(
//       orderId: 1001,
//       amount: 908.0,
//       customerName: 'John Doe',
//       customerPhone: '0123456789',
//       customerEmail: 'test@gmail.com',
//       date: DateTime.now(),
//       paymentStatus: 'paid',
//       fulfillmentStatus: 'fulfilled',
//       deliveryStatus: 'delivered',
//       deliveryMethod: 'delivery',
//       channel: 'online',
//       market: 'amazon',
//       items: [
//         Item(
//             itemId: 1,
//             name: 'Product 1',
//             quantity: 1,
//             price: 100.0,
//             discountedPrice: 90.0,
//             discount: 10.0,
//             variantName: 'variant 1',
//             customShipping: 10.0,
//             customTax: 5.0,
//             type: 'type 1',
//             sku: 'sku 1',
//             barcode: 'barcode 1',
//             weight: 1.0,
//             dimensions: Dimensions(
//               width: 1.0,
//               height: 1.0,
//               length: 1.0,
//             ),
//             vendor: Vendor(vendorId: 1, vendorName: ''),
            
//             media: ['https://via.placeholder.com/150'], category: null),
//         Item(
//             itemId: 2,
//             name: 'Product 2',
//             media: 'https://via.placeholder.com/150',
//             quantity: 1,
//             price: 100.0,
//             discountedPrice: 90.0,
//             discount: 10.0,
//             variantName: 'variant 2',
//             customShipping: 10.0,
//             customTax: 5.0,
//             type: 'type 2',
//             sku: 'sku 2',
//             barcode: 'barcode 2',
//             weight: 2.0,
//             dimensions: Dimensions(
//               width: 2.0,
//               height: 2.0,
//               length: 2.0,
//             ),
//             vendor: Vendor(vendorId: 2, vendorName: '')),
//       ],
//       numberOfProducts: 2,
//       timeline: [],
//       returnItems: [],
//       refundItems: [],
//     );
//   }
// }
