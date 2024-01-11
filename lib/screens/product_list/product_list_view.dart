import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../helper/common_function.dart';
import '../../helper/theme_helper.dart';
import '../../widgets/circular_progress_bar.dart';
import '../../widgets/custom_radiobtn.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class ProductListView extends StatelessWidget {
  ProductListView({super.key});

  final ProductListViewModel viewModel = Get.put(ProductListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addProductBtn(),
              filtrationBar(),
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

  Widget addProductBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: CustomIconTextBtn(
        width: double.minPositive,
        onPressed: () {
          Get.to(() => AddProduct1View(),
              arguments: {'cameFromProductList': true});
        },
        icon: CupertinoIcons.plus,
        title: 'Add Product',
      ),
    );
  }

  Widget filtrationBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField1(
              isDropDown: true,
              filled: false,
              controller: viewModel.statusController,
              onTap: () {
                filterBottomSheet();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ThemeHelper.grey1,
              ),
            ),
            child: Obx(
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
          ),
        ],
      ),
    );
  }

  Widget searchTxtField() {
    return Obx(
      () => viewModel.showSearchTxtField.value
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: CustomTextField1(
                controller: viewModel.searchController,
                filled: false,
                prefixIcon: CupertinoIcons.search,
                hintText: 'Filter by name',
                onChanged: (value) {
                  CommonFunction.debouncer.call(() {
                    viewModel.onChangeSearching(value);
                  });
                },
                suffixIconButton: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    if (viewModel.searchController.text.isEmpty) return;
                    viewModel.searchController.clear();
                    viewModel.onChangeSearching('');
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
          '${viewModel.currentPage.value} of ${viewModel.totalPages.value}',
          style: const TextStyle(
            fontSize: 12,
            color: ThemeHelper.grey2,
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: Obx(
        () => viewModel.dataList.isNotEmpty
            ? Column(
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
                        child: CustomCircularLoader())
                ],
              )
            : viewModel.showListLoader.value
                ? const CustomCircularLoader()
                : const Center(
                    child: Text('No Data Found'),
                  ),
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
          Get.to(() => AddProduct1View(), arguments: {
            'productDetails': viewModel.dataList[index],
            'cameFromProductList': true
          });
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 40,
                width: 40,
                imageUrl: viewModel.dataList[index].media?[0].url ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      borderRadius: BorderRadius.circular(10),
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.dataList[index].name ?? '',
                      style: const TextStyle(
                        color: ThemeHelper.blue1,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: Wrap(
                        children: [
                          Text(
                            '• Category: ${viewModel.dataList[index].categories?[0].name ?? ''}',
                            style: const TextStyle(
                              color: ThemeHelper.grey2,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '• Variants: ${viewModel.dataList[index].variants ?? '0'}',
                            style: const TextStyle(
                              color: ThemeHelper.grey2,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    status(viewModel.dataList[index].status ?? 'N/A'),
                  ],
                ),
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
                  'Product Status',
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
