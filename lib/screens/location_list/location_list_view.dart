import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/add_location/add_location_view.dart';
import 'package:ismmart_vms/screens/location_list/location_list_viewmodel.dart';

import '../../widgets/custom_button.dart';
import '../product_detail/product_detail_view.dart';

class LocationListView extends StatelessWidget {
  LocationListView({super.key});

  final LocationListViewModel viewModel = Get.put(LocationListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              '1 - 3 of 3',
              style: TextStyle(
                fontSize: 12,
                color: ThemeHelper.grey2,
              ),
            ),
          ),
          listView(),
        ],
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconTextBtn(
            width: double.minPositive,
            onPressed: () {
              Get.to(() => AddLocationView());
            },
            icon: CupertinoIcons.plus,
            title: 'Add Location',
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ThemeHelper.grey1,
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      CupertinoIcons.search,
                      size: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCustomDialog();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.filter_list_rounded,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return viewModel.dataList.isNotEmpty
        ? Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.dataList.length,
              itemBuilder: (context, int index) {
                return listViewItem(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: ThemeHelper.grey1,
                  thickness: 0.8,
                  height: 0,
                );
              },
            ),
          )
        : const Center(
            child: Text('No Data Found'),
          );
  }

  Widget listViewItem(int index) {
    BorderRadius borderRadius = listBorderRadius(index);
    return Material(
      color: ThemeHelper.grey3,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          Get.to(() => ProductDetailView());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ThemeHelper.grey1,
                        // width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 17,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Beverly Center',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            status(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Utah  \u25CF  United States',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: ThemeHelper.grey2,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            '2118 G-8/1, Islamabad 35624',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: ThemeHelper.grey2,
                            ),
                          ),
                        ),
                        const Text(
                          '2118 G-8/1, Islamabad 35624',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: ThemeHelper.grey2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u25CF Last updated',
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeHelper.grey2,
                    ),
                  ),
                  Text(
                    'April 23,2023',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius listBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.vertical(top: Radius.circular(12));
    } else if (index == viewModel.dataList.length-1) {
      return const BorderRadius.vertical(bottom: Radius.circular(12));
    } else {
      return BorderRadius.zero;
    }
  }

  Widget status() {
    Color color = statusColor('1');
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(left: 4, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Active',
              style: TextStyle(
                color: color,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color statusColor(String value) {
    if (value == '1') {
      return const Color(0xFF06D38F);
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  //////////////////////////////////////////////////////////////////////
  /////////////////////// OLD CODE
  /////////////////////////////////////////////////////////////////////

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
