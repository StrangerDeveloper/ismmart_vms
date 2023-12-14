import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/model/order_model.dart';

// Import your models here

class OrderViewModel extends GetxController {
  // var order = Order(
  //   orderId: 1,
  //   amount: 0.0,
  //   customerName: '',
  //   customerPhone: '',
  //   customerEmail: '',
  //   numberOfProducts: 0,
  //   date: DateTime.now(),
  //   paymentStatus: '',
  //   fulfillmentStatus: '',
  //   deliveryStatus: '',
  //   deliveryMethod: '',
  //   channel: '',
  //   market: '',
  //   items: [],
  //   timeline: [],
  //   returnItems: [],
  //   refundItems: [],
  // ).obs;

  var orders = <Order>[].obs;

  // Simulating data fetching from an API or database
  void fetchOrders(
      var orderItem, var timelineItem, var returnItem, var refundItem) {
    // Creating a list of Order objects
    List<Order> fetchedOrders = [
      Order(
        orderId: 1,
        amount: 0.0,
        customerName: 'Umair',
        customerPhone: '0340950837',
        customerEmail: '',
        numberOfProducts: 0,
        date: DateTime.now(),
        paymentStatus: 'paid',
        fulfillmentStatus: 'fulfilled',
        deliveryStatus: 'delivered',
        deliveryMethod: '',
        channel: '',
        market: '',
        items: orderItem,
        timeline: [],
        returnItems: [],
        refundItems: [],
      ),
      // Add more Order instances as needed
    ];

    // Assigning the fetched orders to the orders list
    orders.assignAll(fetchedOrders);
  }

  // Simulating data fetching from an API or database
  void fetchOrderDetails() {
    // Simulated data for items
    List<Item> items = [
      Item(
        itemId: 1,
        name: 'Product 1',
        media: ['https://via.placeholder.com/150'],
        quantity: 2,
        price: 50.0,
        discountedPrice: 45.0,
        discount: 5.0,
        variantName: 'Variant A',
        customShipping: 5.0,
        customTax: 2.0,
        vendor: Vendor(vendorId: 1, name: '', vendorName: 'Vendor 1'),
        type: 'Type A',
        category: Category.electronics,
        sku: 'SKU-123',
        barcode: '123456789',
        weight: 1.5,
        dimensions: Dimensions(width: 5.0, height: 3.0, length: 4.0),
      ),
      Item(
        itemId: 2,
        name: 'Product 2',
        media: ['https://via.placeholder.com/150'],
        quantity: 2,
        price: 50.0,
        discountedPrice: 45.0,
        discount: 5.0,
        variantName: 'Variant A',
        customShipping: 5.0,
        customTax: 2.0,
        vendor: Vendor(vendorId: 1, name: '', vendorName: 'Vendor 1'),
        type: 'Type A',
        category: Category.electronics,
        sku: 'SKU-123',
        barcode: '123456789',
        weight: 1.5,
        dimensions: Dimensions(width: 5.0, height: 3.0, length: 4.0),
      ),

      // Add more items as needed
    ];

    // Simulated data for timeline items
    List<TimelineItem> timelineItems = [
      TimelineItem(
        status: 'Ordered',
        dated: DateTime(2023, 12, 10),
        user: User(userId: 1, userName: 'Customer'),
      ),
      // Add more timeline items as needed
    ];

    // Simulated data for return items
    List<ReturnItem> returnItems = [
      ReturnItem(
        returnId: 1,
        name: 'Returned Product',
        media: ['https://via.placeholder.com/150'],
        quantityReturned: 1,
        price: 30.0,
        discountedPrice: 25.0,
        discount: 5.0,
        variantName: 'Variant X',
        customShipping: 3.0,
        customTax: 1.0,
        vendor: Vendor(vendorId: 2, vendorName: 'Vendor 2', name: ''),
        type: 'Type B',
        category: Category.fashion,
        sku: 'SKU-456',
        barcode: '987654321',
        weight: 1.0,
        dimensions: Dimensions(width: 3.0, height: 2.0, length: 3.0),
      ),
      // Add more return items as needed
    ];

    // Simulated data for refund items
    List<RefundItem> refundItems = [
      RefundItem(
        refundId: 1,
        name: 'Refunded Product',
        media: ['https://via.placeholder.com/150'],
        quantityRefunded: 1,
        price: 40.0,
        discountedPrice: 35.0,
        discount: 5.0,
        variantName: 'Variant Y',
        customShipping: 4.0,
        customTax: 2.0,
        vendor: Vendor(vendorId: 3, vendorName: 'Vendor 3', name: ''),
        type: 'Type C',
        category: Category.grocery,
        sku: 'SKU-789',
        barcode: '24681012',
        weight: 2.0,
        dimensions: Dimensions(width: 4.0, height: 2.5, length: 5.0),
      ),
      // Add more refund items as needed
    ];
    fetchOrders(items, timelineItems, returnItems, refundItems);

    // // Constructing the order object with fetched data
    // order.value = Order(
    //   orderId: 1001,
    //   amount: 200.0,
    //   customerName: 'John Doe',
    //   customerPhone: '1234567890',
    //   customerEmail: 'john@example.com',
    //   numberOfProducts: items.length,
    //   date: DateTime(2023, 12, 9),
    //   paymentStatus: 'Paid',
    //   fulfillmentStatus: 'Fulfilled',
    //   deliveryStatus: 'Delivered',
    //   deliveryMethod: 'Home Delivery',
    //   channel: 'Online',
    //   market: 'Amazon',
    //   items: items,
    //   timeline: timelineItems,
    //   returnItems: returnItems,
    //   refundItems: refundItems,
    // );
  }
}






// import 'package:get/get.dart';
// import 'package:ismmart_vms/screens/Order/model/order_model.dart';

// class OrderViewModel extends GetxController {
//   var order = Order(
//     orderId: 1,
//     amount: 0.0,
//     customerName: "abcd",
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

//   Future<void> fetchOrderDetails(int orderId) async {
//     try {
//       // will Fetch order details from our API service by passing the orderId
//       // will Replace this with our actual API call to fetch order details
//       // Example:
//       // final response = await ourApiService.getOrderDetails(orderId);

//       // For demonstration, using hardcoded data (will replace with API call later)
//       final response =
//           hardcodedOrderData(); // will replace with our API call later

//       // Parse the response data and update the order value
//       order.value = Order(
//         orderId: response['orderId'],
//         amount: response['amount'],
//         customerName: response['customerName'],
//         customerPhone: response['customerPhone'],
//         customerEmail: response['customerEmail'],
//         date: response['date'],
//         paymentStatus: response['paymentStatus'],
//         fulfillmentStatus: response['fulfillmentStatus'],
//         deliveryStatus: response['deliveryStatus'],
//         deliveryMethod: response['deliveryMethod'],
//         channel: response['channel'],
//         market: response['market'],
//         items: response['items'], // Update with parsed item data
//         numberOfProducts: response['numberOfProducts'],
//         timeline: response['timeline'], // Update with parsed timeline data
//         returnItems: response['returnItems'], // Update with parsed return items
//         refundItems: response['refundItems'], // Update with parsed refund items
//       );
//     } catch (e) {
//       print('Error fetching order details: $e');
//     }
//   }

//   // Hardcoded order data for demonstration (will replace this with API call)
//   Map<String, dynamic> hardcodedOrderData() {
//     return {
//       'orderId': 1001,
//       'amount': 908.0,
//       'customerName': 'John Doe',
//       'customerPhone': '0123456789',
//       'customerEmail': 'test@gmail.com',
//       'date': DateTime.now(),
//       'paymentStatus': 'paid',
//       'fulfillmentStatus': 'fulfilled',
//       'deliveryStatus': 'delivered',
//       'deliveryMethod': 'delivery',
//       'channel': 'online',
//       'market': 'amazon',
//       'items': [
//         {
//           'itemId': 1,
//           'name': 'Product 1',
//           // ... Other item details
//         },
//         {
//           'itemId': 2,
//           'name': 'Product 2',
//           // ... Other item details
//         },
//       ],
//       'numberOfProducts': 2,
//       'timeline': [],
//       'returnItems': [],
//       'refundItems': [],
//     };
//   }
// }
