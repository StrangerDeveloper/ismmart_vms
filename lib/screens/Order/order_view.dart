import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/Order/order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewModel orderController = Get.put(OrderViewModel());

    // Fetch order details based on orderId
    orderController.fetchOrderDetails(1001);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order Details',
        backBtn: false,
        action: [
          IconButton(
            onPressed: () {
              Get.to(() => const OrderView());
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Order',
                middleText: 'Are you sure you want to delete this order?',
                textConfirm: 'Yes',
                textCancel: 'No',
                onConfirm: () {
                  // Delete order
                  Get.back();
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),

      // appBar: AppBar(
      //   title: const Text('Order Details'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Get.to(() => const OrderView());
      //       },
      //       icon: const Icon(Icons.edit),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Get.defaultDialog(
      //           title: 'Delete Order',
      //           middleText: 'Are you sure you want to delete this order?',
      //           textConfirm: 'Yes',
      //           textCancel: 'No',
      //           onConfirm: () {
      //             // Delete order
      //             Get.back();
      //           },
      //         );
      //       },
      //       icon: const Icon(Icons.delete),
      //     ),
      //   ],
      // ),
      body: Obx(
        () => orderController.order.value.orderId == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildOrderDetailCard(
                      title: 'Order ID',
                      subtitle: orderController.order.value.orderId.toString(),
                    ),
                    buildOrderDetailCard(
                      title: 'Customer Name',
                      subtitle: orderController.order.value.customerName,
                    ),
                    buildOrderDetailCard(
                      title: 'Customer Phone',
                      subtitle: orderController.order.value.customerPhone,
                    ),
                    buildOrderDetailCard(
                      title: 'Customer Email',
                      subtitle: orderController.order.value.customerEmail,
                    ),
                    buildOrderDetailCard(
                      title: 'Number of Products',
                      subtitle: orderController.order.value.numberOfProducts
                          .toString(),
                    ),
                    buildOrderDetailCard(
                      title: 'Date',
                      subtitle: orderController.order.value.date.toString(),
                    ),
                    buildOrderDetailCard(
                      title: 'Payment Status',
                      subtitle: orderController.order.value.paymentStatus,
                    ),
                    buildOrderDetailCard(
                      title: 'Fulfillment Status',
                      subtitle: orderController.order.value.fulfillmentStatus,
                    ),
                    buildOrderDetailCard(
                      title: 'Delivery Status',
                      subtitle: orderController.order.value.deliveryStatus,
                    ),
                    buildOrderDetailCard(
                      title: 'Delivery Method',
                      subtitle: orderController.order.value.deliveryMethod,
                    ),
                    buildOrderDetailCard(
                      title: 'Channel',
                      subtitle: orderController.order.value.channel,
                    ),
                    buildOrderDetailCard(
                      title: 'Market',
                      subtitle: orderController.order.value.market,
                    ),
                    // Add more buildOrderDetailCard widgets for other details
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildOrderDetailCard(
      {required String title, required String subtitle}) {
    return Card(
      color: kWhiteColor,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: CustomText(
          title: title,
          color: kWhiteColor,
          size: 15,
        ),
        subtitle: CustomText(
          title: subtitle,
          color: kWhiteColor,
          size: 15,
        ),
      ),
    );
  }
}
