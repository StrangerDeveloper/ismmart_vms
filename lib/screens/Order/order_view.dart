import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/Order/model/order_model.dart';
import 'package:ismmart_vms/screens/Order/order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

class OrderView extends StatelessWidget {
  OrderView({Key? key}) : super(key: key) {
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderController.orders.length,
                        itemBuilder: (context, index) {
                          final detail = orderController.orders[index];
                          return _buildOrderDetail(detail);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                //Get.to(() => AddEditOrderView());
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text('Edit Order'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Delete Order',
                                  middleText:
                                      'Are you sure you want to delete this order?',
                                  textConfirm: 'Yes',
                                  textCancel: 'No',
                                  onConfirm: () {
                                    // Delete order
                                    Get.back();
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete Order'),
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

  Widget _buildOrderDetail(Order detail) {
    List<TableRow> rows = [
      _buildTableRow("Order ID", detail.orderId.toString()),
      _buildTableRow("Amount", detail.amount.toString()),
      _buildTableRow("Customer Name", detail.customerName),
      _buildTableRow("Date", detail.date.toString()),
      _buildTableRow("Payment Status", detail.paymentStatus),
      _buildTableRow("Fulfillment Status", detail.fulfillmentStatus),
      _buildTableRow("Delivery Status", detail.deliveryStatus),
      // Add other details as needed
    ];

    // Add a table row for items
    rows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Items", textAlign: TextAlign.start),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: _buildItemDetails(detail.items),
            ),
          ),
        ],
      ),
    );

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: rows,
    );
  }

  List<Widget> _buildItemDetails(List<Item> items) {
    return items.map((item) {
      return _buildItemDetail(item);
    }).toList();
  }

  Widget _buildItemDetail(Item itemDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(title: "Item ID: ${itemDetails.itemId}"),
          CustomText(title: "Name: ${itemDetails.name}"),
          CustomText(title: "Quantity: ${itemDetails.media}"),
          CustomText(title: "Price: ${itemDetails.quantity}"),
          CustomText(title: "Price: ${itemDetails.price}"),
          CustomText(title: "Discounted Price: ${itemDetails.discountedPrice}"),
          CustomText(title: "SKU: ${itemDetails.sku}"),
          CustomText(title: "Barcode: ${itemDetails.barcode}"),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, textAlign: TextAlign.start),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, textAlign: TextAlign.start),
        ),
      ],
    );
  }
}
