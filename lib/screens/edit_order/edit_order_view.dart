// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ismmart_vms/screens/Order/order_viewModel.dart';

// class AddEditOrderView extends StatelessWidget {
//   final OrderViewModel orderController = Get.find<OrderViewModel>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add/Edit Order'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           // Define your form fields and validation
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 // Order ID field
//                 decoration: InputDecoration(labelText: 'Order ID'),
//                 initialValue: orderController.order.value.orderId.toString(),
//                 readOnly: true, // For editing, set this to false
//                 // Add logic to update the order ID if editing is allowed
//               ),
//               TextFormField(
//                 // Customer Name field
//                 decoration: InputDecoration(labelText: 'Customer Name'),
//                 initialValue: orderController.order.value.customerName,
//                 // Logic to update customer name
//               ),
//               // Add more TextFormField widgets for other order details (phone, email, etc.)
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Save or update order logic goes here
//                   // For instance, call a method in OrderViewModel to save/update the order
//                 },
//                 child: Text('Save Order'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
