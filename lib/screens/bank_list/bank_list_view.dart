import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_viewmodel.dart';

import '../../helper/theme_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_radiobtn.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class BankListView extends StatelessWidget {
  BankListView({super.key});

  final BankListViewModel viewModel = Get.put(BankListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                topBar(),
                searchTxtField(),
                listView(),
                addNewBankBtn(),
              ],
            ),
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

  // Widget listView() {
  //   return Obx(
  //     () => viewModel.dataList.isNotEmpty
  //         ? Expanded(
  //             child: ListView.separated(
  //               padding: const EdgeInsets.all(16),
  //               itemCount: viewModel.dataList.length,
  //               itemBuilder: (context, int index) {
  //                 return listViewItem(index);
  //               },
  //               separatorBuilder: (BuildContext context, int index) {
  //                 return const Divider(
  //                   color: ThemeHelper.grey1,
  //                   thickness: 0.8,
  //                   height: 0,
  //                 );
  //               },
  //             ),
  //           )
  //         : const Center(
  //             child: Text('No Data Found'),
  //           ),
  //   );
  // }

  Widget listView() {
    return true
        ? ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, int index) {
              return listViewItem(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16);
            },
          )
        : const SizedBox(
            height: 200,
            child: Center(
              child: Text('No Data Found'),
            ),
          );
  }

  Widget listViewItem(int index) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red,),
      key: UniqueKey(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF9FAFB)),
                child: CachedNetworkImage(
                  height: 34,
                  width: 34,
                  imageUrl: '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/logo/logo_new.png'),
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
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meezan Bank',
                      style: TextStyle(
                        color: ThemeHelper.blue1,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ashar Atique',
                      style: TextStyle(
                        color: ThemeHelper.grey5,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewBankBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: CustomTextBtn(
        height: 56,
        radius: 16,
        backgroundColor: ThemeHelper.grey3,
        foregroundColor: ThemeHelper.blue1,
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Add new bank',
              style: TextStyle(
                color: ThemeHelper.blue1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: ThemeHelper.blue1,
            )
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
                  viewModel.getData();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
