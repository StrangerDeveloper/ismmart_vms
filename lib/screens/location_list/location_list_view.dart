import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_address/add_address_view.dart';
import 'package:ismmart_vms/screens/location_list/location_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../product_detail/product_detail_view.dart';

class LocationListView extends StatelessWidget {
  LocationListView({super.key});

  final LocationListViewModel viewModel = Get.put(LocationListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(()=>AddAddressView());
        },
        label: const Text('Add Address'),
      ),
      appBar: AppBar(
        title: const Text('Location'),
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
          return const Divider();
        },
      ),
    );
  }

  Widget listViewItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailView());
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item1(title: 'Name', value: 'Home'),
            item1(title: 'Country', value: 'Pakistan'),
            item1(title: 'City', value: 'Rawalpindi'),
            item1(title: 'Address', value: 'Commercial Market, Satellite Town'),
            item1(title: 'Phone', value: '03345462055'),
            item1(title: 'Status', value: 'Active'),
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
                    filterItem(title: 'Name'),
                    filterItem(title: 'Country'),
                    filterItem(title: 'City'),
                    filterItem(title: 'Status'),
                    filterItem(title: 'Created At'),
                    filterItem(title: 'Updated At'),
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
