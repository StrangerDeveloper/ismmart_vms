import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
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
    return InkWell(
      onTap: () {
        Get.to(() => AddProduct1View(), arguments: {
          'productDetails': viewModel.dataList[index],
          'cameFromProductList': true
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 45,
              width: 45,
              imageUrl: viewModel.dataList[index].media?[0].url ?? '',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.dataList[index].name ?? '',
                  style: interHeadingSize15.copyWith(color: newColorBlue),
                ),
                SizedBox(height: 3.h),
                Text(
                  '• Category: ${viewModel.dataList[index].categories?[0].name ?? ''}',
                  style: interNormalText.copyWith(
                      color: newColorLightGrey2, fontSize: 11),
                ),
                Text(
                  '• Variants: ${viewModel.dataList[index].variants}',
                  style: interNormalText.copyWith(
                      color: newColorLightGrey2, fontSize: 11),
                ),
                SizedBox(height: 15.h),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: viewModel.dataList[index].status!
                              .toLowerCase()
                              .contains("active")
                          ? productActiveColor.withOpacity(0.25)
                          : newColorLightGrey2.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: viewModel.dataList[index].status!
                                .toLowerCase()
                                .contains("active")
                            ? productActiveColor
                            : newColorLightGrey2,
                      ),
                      SizedBox(width: 10.v),
                      Text(
                        viewModel.dataList[index].status ?? 'N/A',
                        style: interNormalText.copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: newColorLightGrey2,
                  height: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
