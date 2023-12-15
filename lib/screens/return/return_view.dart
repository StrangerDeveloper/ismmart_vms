import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/Order/model/order_model.dart';
import 'package:ismmart_vms/screens/Order/order_viewModel.dart';
import 'package:ismmart_vms/screens/return/model.dart';
import 'package:ismmart_vms/screens/return/return_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../order_detail/order_detail_view.dart';

class RefundView extends StatefulWidget {
  RefundView({super.key}) {
    Get.put(OrderViewModel()).fetchOrderDetails();
  }

  @override
  State<RefundView> createState() => _RefundViewState();
}

class _RefundViewState extends State<RefundView> {
  @override
  Widget build(BuildContext context) {
    final ReturnViewModel viewModel = Get.put(ReturnViewModel());

    return Scaffold(
      appBar: CustomAppBar(
        title: "Return List",
        backBtn: false,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.returnItemList.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.returnItemList[index];
                    return GestureDetector(
                      onTap: () {
                        if (viewModel.selectedItemList.contains(item.id)) {
                          viewModel.selectedItemList
                              .removeWhere((element) => element == item.id);
                          viewModel.selectedItemList.refresh();
                        } else {
                          viewModel.selectedItemList.add(item.id!);
                          viewModel.selectedItemList.refresh();
                        }
                        setState(() {});
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(20),
                            ), //BoxDecoration

                            child: ListTile(
                              title: Text(item.name.toString()),
                              subtitle: Column(
                                children: [
                                  Text(item.discription.toString()),
                                  Text(item.color.toString()),
                                  Text(item.quantity.toString()),
                                ],
                              ),
                              trailing: viewModel.selectedItemList
                                      .contains(item.id)
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.check_box_outline_blank),
                            ), //CheckboxListTile
                          ), //Container
                        ), //Padding
                      ),
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
                        icon: const Icon(Icons.shopping_cart_checkout_sharp),
                        label: Text(
                            'Return Items ${viewModel.selectedItemList.length}'),
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

  Widget _buildOrderCard(ReturnModel item) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderCardContent("Order ID", item.id.toString()),
            _buildOrderCardContent("Customer Name", item.name.toString()),
            _buildOrderCardContent("Discription", item.discription.toString()),
            _buildOrderCardContent("Item Color", item.color.toString()),
            _buildOrderCardContent("Total Amount", item.quantity.toString()),
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
