import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/create_payout/create_payout_view.dart';
import 'package:ismmart_vms/screens/payout_list/payout_list_viewmodel.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_radiobtn.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';
import '../product_detail/product_detail_view.dart';

class PayoutListView extends StatelessWidget {
  PayoutListView({super.key});

  final PayoutListViewModel viewModel = Get.put(PayoutListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payouts'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(),
              topBar2(),
              searchTxtField(),
              const Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  '1 - 20 of 50',
                  style: TextStyle(
                    fontSize: 12,
                    color: ThemeHelper.grey2,
                  ),
                ),
              ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconTextBtn(
            width: double.minPositive,
            onPressed: () {
              Get.to(() => CreatePayoutView());
            },
            icon: CupertinoIcons.plus,
            title: ' Create Payouts ',
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ThemeHelper.grey1,
              ),
            ),
            child: CustomIconBtn(
              icon: Icons.more_vert_rounded,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget topBar2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextField1(
              hintText: 'Select the Status',
              readOnly: true,
              isDropDown: true,
              filled: false,
              onTap: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
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
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CustomTextField1(
                filled: false,
                prefixIcon: CupertinoIcons.search,
                hintText: 'Filter by name',
              ),
            )
          : const SizedBox(height: 16),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.payoutList.isNotEmpty
          ? Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: viewModel.scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: viewModel.payoutList.length,
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
          Get.to(() => ProductDetailView());
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 48,
                width: 48,
                imageUrl: "",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
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
                      borderRadius: BorderRadius.circular(4),
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
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Store Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ThemeHelper.blue1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${viewModel.payoutList[index].amount ?? 0}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        '${viewModel.payoutList[index].amount ?? 0}',
                        style: const TextStyle(
                          color: ThemeHelper.red1,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\u25CF ${viewModel.payoutList[index].method ?? 'N/A'}',
                          style: const TextStyle(
                            color: ThemeHelper.grey2,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '\u25CF ${viewModel.payoutList[index].method != null ? CommonFunction.convertDateFormat(viewModel.payoutList[index].requestedDate!) : 'N/A'}',
                          style: const TextStyle(
                            color: ThemeHelper.grey2,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 13),
                      child: Text(
                        '\u25CF ${viewModel.payoutList[index].amount ?? 0}',
                        style: const TextStyle(
                          color: ThemeHelper.grey2,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    status(),
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
    } else if (index == viewModel.payoutList.length - 1) {
      return const BorderRadius.vertical(bottom: Radius.circular(12));
    } else {
      return BorderRadius.zero;
    }
  }

  Widget status() {
    Color color = statusColor('1');
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(30),
      ),
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
                    viewModel.filterRadioBtn.value = value;
                  },
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'Paid',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'paid',
                  onChanged: (value) {
                    viewModel.filterRadioBtn.value = value;
                  },
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'Unpaid',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'unpaid',
                  onChanged: (value) {
                    viewModel.filterRadioBtn.value = value;
                  },
                ),
              ),
              Obx(
                () => CustomRadioButton2(
                  title: 'Rejected',
                  groupValue: viewModel.filterRadioBtn.value,
                  value: 'rejected',
                  onChanged: (value) {
                    viewModel.filterRadioBtn.value = value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomTextBtn(
                title: 'Done',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
