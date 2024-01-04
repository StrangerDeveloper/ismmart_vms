import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/product_detail/product_detail_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../widgets/custom_checkbox_list_tile.dart';
import '../../widgets/loader_view.dart';
import '../product_quantity/product_quantity_view.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});

  final ProductDetailViewModel viewModel = Get.put(ProductDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    CustomTextBtn(
                      title: 'Product Inventory',
                      onPressed: () {
                        // itemsBottomSheet();
                        Get.to(() => ProductQuantity());
                      },
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Wrap(
                        children: viewModel.dataList
                            .map(
                              (e) => e.isSelected == true
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(e.name ?? ''),
                                    )
                                  : const SizedBox(),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  itemsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Sources',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.5,
                    ),
                  ),
                  Obx(
                    () => CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      radius: 4,
                      width: 100,
                      child: Text(viewModel.selectAllValue.value
                          ? 'Unselect'
                          : 'Select All'),
                      onPressed: () {
                        viewModel.selectAllItems();
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              sourcesList(),
              const Divider(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sourcesList() {
    return Expanded(
      child: Obx(
        () => viewModel.dataList.isNotEmpty
            ? ListView.builder(
                itemCount: viewModel.dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(
                    () => CheckBoxListTile1(
                      title: viewModel.dataList[index].name ?? '',
                      value: viewModel.dataList[index].isSelected,
                      isSelected: viewModel.dataList[index].isSelected,
                      onChanged: (value) {
                        viewModel.selectSingleItem(value, index);
                      },
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Data Found'),
              ),
      ),
    );
  }
}
