import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/create_payout/create_payout_view.dart';
import 'package:ismmart_vms/screens/payout_list/payout_list_viewmodel.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(),
          topBar2(),
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
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
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
                CustomIconBtn(
                  icon: CupertinoIcons.search,
                  onTap: () {},
                ),
                CustomIconBtn(
                  icon: Icons.filter_list_rounded,
                  onTap: () {},
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
                    const Row(
                      children: [
                        Expanded(
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
                            'Rs. 165,820.00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        'Vendor Name',
                        style: TextStyle(
                          color: ThemeHelper.red1,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          '\u25CF Bank Transfer',
                          style: TextStyle(
                            color: ThemeHelper.grey2,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          '\u25CF Meezan Bank Ltd',
                          style: TextStyle(
                            color: ThemeHelper.grey2,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 13),
                      child: Text(
                        '\u25CF 15 April 2023',
                        style: TextStyle(
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
    } else if (index == viewModel.dataList.length - 1) {
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
