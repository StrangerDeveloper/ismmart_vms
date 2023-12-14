import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/Order/model/order_model.dart';
import 'package:ismmart_vms/screens/Order/order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../order_detail/order_detail_view.dart';

class OrderView extends StatelessWidget {
  OrderView({super.key}) {
    Get.put(OrderViewModel()).fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    final OrderViewModel orderController = Get.find<OrderViewModel>();

    return Scaffold(
      appBar: CustomAppBar(
        title: langKey.orderDetail.tr,
        backBtn: false,
      ),
      body: Obx(
        () => orderController.orders.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderController.orders.length,
                        itemBuilder: (context, index) {
                          final detail = orderController.orders[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => OrderDetailView(order: detail));
                            },
                            child: _buildOrderCard(detail),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Get.to(() => AddOrderView());
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Order'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildOrderCard(Order detail) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderCardContent("Order ID", detail.orderId.toString()),
            _buildOrderCardContent("Customer Name", detail.customerName),
            _buildOrderCardContent("Date", detail.date.toString()),
            _buildOrderCardContent(
                "Fulfillment Status", detail.fulfillmentStatus),
            _buildOrderCardContent("Total Amount", detail.amount.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCardContent(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title: "$title:"),
          CustomText(
            title: value,
          ),
        ],
      ),
    );
  }
}
