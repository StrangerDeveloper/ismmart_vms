import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/product_quantity/product_quantity_viewmodel.dart';

class ProductQuantity extends StatelessWidget {
  ProductQuantity({super.key});
  final ProductQuantityViewModel viewModel = Get.put(ProductQuantityViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Quantity'),
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, int index) {
        return listViewItem(index);
      },
    );
  }

  Widget listViewItem(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location Name'),
          Text('Unavailable'),
          Text('Commited'),
          Text('Available'),
          Text('On Hand'),
        ],
      ),
    );
  }
}
