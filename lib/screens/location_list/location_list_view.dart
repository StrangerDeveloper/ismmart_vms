import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/add_location/add_location_view.dart';
import 'package:ismmart_vms/screens/location_list/location_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/common_function.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_radiobtn.dart';
import '../../widgets/custom_textfield.dart';

class LocationListView extends StatelessWidget {
  LocationListView({super.key});

  final LocationListViewModel viewModel = Get.put(LocationListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(),
              searchTxtField(),
              pageNoView(),
              listView(),
            ],
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconTextBtn(
            width: double.minPositive,
            onPressed: () {
              Get.to(() => AddLocationView(), arguments: {'editData' : false});
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
                Obx(
                  () => CustomIconBtn2(
                    icon: CupertinoIcons.search,
                    color: viewModel.showSearchTxtField.value
                        ? ThemeHelper.blue1
                        : null,
                    onTap: () {
                      viewModel.showSearchTxtField.value =
                          !viewModel.showSearchTxtField.value;
                    },
                  ),
                ),
                CustomIconBtn(
                  icon: Icons.filter_list_rounded,
                  onTap: () {
                    filterBottomSheet();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchTxtField() {
    return Obx(
      () => viewModel.showSearchTxtField.value
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField1(
                controller: viewModel.searchController,
                filled: false,
                prefixIcon: CupertinoIcons.search,
                hintText: 'Filter by name',
                onFieldSubmitted: (value) {
                  viewModel.searchTxtFieldSubmitted(value);
                },
                suffixIconButton: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    viewModel.searchController.clear();
                    viewModel.searchTxtFieldSubmitted('');
                  },
                  icon: const Icon(
                    Icons.close,
                    color: ThemeHelper.grey2,
                  ),
                ),
              ),
            )
          : const SizedBox(height: 16),
    );
  }

  Widget pageNoView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Obx(
        () => Text(
          '${viewModel.pageNo} of ${viewModel.totalPages.value}',
          style: const TextStyle(
            fontSize: 12,
            color: ThemeHelper.grey2,
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.dataList.isNotEmpty
          ? Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: viewModel.scrollController,
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
                  ),
                  if (viewModel.paginationLoader.value)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                ],
              ),
            )
          : const Center(
              child: Text('No Data Found'),
            ),
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
          Get.to(
            () => AddLocationView(),
            arguments: {
              'editData': true,
              'model': viewModel.dataList[index],
            },
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
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
                            Text(
                              viewModel.dataList[index].name ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            status(
                              viewModel.dataList[index].status ?? 'N/A',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${viewModel.dataList[index].country?.name ?? 'N/A'} \u25CF ${viewModel.dataList[index].city?.name ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: ThemeHelper.grey2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            viewModel.dataList[index].address ?? 'N/A',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: ThemeHelper.grey2,
                            ),
                          ),
                        ),
                        // Text(
                        //   viewModel.dataList[index].phone ?? 'N/A',
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 10,
                        //     color: ThemeHelper.grey2,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '\u25CF Last updated',
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeHelper.grey2,
                    ),
                  ),
                  Text(
                    viewModel.dataList[index].updatedAt != null
                        ? CommonFunction.convertDateFormat(
                            viewModel.dataList[index].updatedAt!)
                        : 'N/A',
                    style: const TextStyle(
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
    } else if (index == viewModel.dataList.length - 1) {
      return const BorderRadius.vertical(bottom: Radius.circular(12));
    } else {
      return BorderRadius.zero;
    }
  }

  Widget status(String value) {
    Color color = statusColor(value);
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(left: 4, top: 3, bottom: 3),
      decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              value,
              style: TextStyle(
                color: statusTxtColor(value),
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color statusColor(String value) {
    if (value == 'Active') {
      return const Color(0xFF06D38F);
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  Color statusTxtColor(String value) {
    if (value == 'Active') {
      return Colors.black;
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  filterBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: ThemeHelper.blue1,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeHelper.blue1,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Payout Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'All',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'all',
                  onChanged: (value) {
                    viewModel.radioBtnSelection(value);
                  },
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'Active',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'Active',
                  onChanged: (value) {
                    viewModel.radioBtnSelection(value);
                  },
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'Inactive',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'In-Active',
                  onChanged: (value) {
                    viewModel.radioBtnSelection(value);
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextBtn(
                title: 'Done',
                onPressed: () {
                  Get.back();
                  viewModel.getDataFunction();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
