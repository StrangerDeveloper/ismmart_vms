import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../product_detail/product_detail_view.dart';

class PayoutsView extends StatelessWidget {
  PayoutsView({super.key});

  final ProductListViewModel viewModel = Get.put(ProductListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payouts'),
        actions: [
          IconButton(
            onPressed: () {
              showCustomDialog();
            },
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Filter by : ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Obx(
                  () => Text(
                    viewModel.searchBy.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextField2(
              hintText: 'Search...',
            ),
          ),
          listView(),
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, int index) {
          return listViewItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  Widget listViewItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => const ProductDetailView());
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item1(title: 'Requested Date', value: '13 Dec, 2023'),
            item1(title: 'Amount', value: '10,000'),
            item1(title: 'Bank Name', value: 'Alfalah Bank'),
            item1(title: 'Transfer Method', value: 'Bank'),
            item1(title: 'Status', value: 'Transfered'),
            item1(title: 'Created At', value: '13 Dec, 2023'),
            item1(title: 'Updated At', value: '13 Dec, 2023'),
          ],
        ),
      ),
    );
  }

  Widget item1({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(),
          ),
          Text(
            value,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }

  Future showCustomDialog() async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filter by',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    filterItem(title: 'Requested Date'),
                    filterItem(title: 'Amount'),
                    filterItem(title: 'Bank Name'),
                    filterItem(title: 'Transfer Method'),
                    filterItem(title: 'Status'),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget filterItem({required String title}) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        viewModel.searchBy.value = title;
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            if (viewModel.searchBy.value == title)
              const Icon(
                Icons.check,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
