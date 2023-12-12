import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../product_quantity/product_quantity_view.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        children: [
          CustomTextBtn(
            title: 'Product Inventory',
            onPressed: () {
              Get.to(()=>ProductQuantity());
            },
          ),
        ],
      ),
    );
  }
}
