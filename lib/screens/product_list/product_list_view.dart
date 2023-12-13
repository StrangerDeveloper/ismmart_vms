import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../product_detail/product_detail_view.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final ProductListViewModel viewModel = Get.put(ProductListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
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
              hintText: 'Search Product...',
            ),
          ),
          listView(),
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) {
          return listViewItem(index);
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
        child: Row(
          children: [
            CachedNetworkImage(
              height: 65,
              width: 65,
              imageUrl: "",
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/no_image_found.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                );
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item1(title: 'Name', value: 'Product Name '),
                  item1(title: 'Type', value: 'Men Shirt'),
                  item1(title: 'Category', value: 'Cloths'),
                  item1(title: 'Variants Count/Inventory', value: '10'),
                  item1(title: 'Starting Price', value: '1500'),
                  item1(title: 'No of Items', value: '100'),
                ],
              ),
            ),
          ],
        ),
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
                    filterItem(title: 'Status'),
                    filterItem(title: 'Variant'),
                    filterItem(title: 'Location'),
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
