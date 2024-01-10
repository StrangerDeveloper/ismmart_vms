import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_listing/order_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../../helper/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/loader_view.dart';
import '../order_detail/order_detail_view.dart';

class OrderView extends StatelessWidget {
  final OrderListingViewModel viewModel = Get.put(OrderListingViewModel());
  OrderView({super.key, this.callingFor = 'All'});

  final String? callingFor;

  @override
  Widget build(BuildContext context) {
    if (callingFor!.toLowerCase().contains('returned')) {
      viewModel.fieldSelection("Returned");
    } else if (callingFor!.toLowerCase().contains('cancelled')) {
      viewModel.fieldSelection("Cancelled");
    }

    return Scaffold(
      //appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17.0, bottom: 17.0),
                  child: _buildSearchRow(),
                ),
                Obx(
                  () => viewModel.orderItemList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Obx(
                            () => ListView.builder(
                              controller: viewModel.scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.orderItemList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => OrderDetailView(),
                                      arguments: {
                                        'model': viewModel.orderItemList[index],
                                      },
                                    );
                                  },
                                  child: _buildOrderCard(index),
                                );
                              },
                            ),
                          ),
                        )
                      : const Center(
                          child: Text('No Data Found'),
                        ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar2(
      title: "Order List",
    );
  }

  Widget _buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250.h,
          child: CustomTextField1(
            controller: viewModel.searchController,
            filled: false,
            hintText: callingFor!,
            isDropDown: true,
            onTap: () {
              statusBottomSheet();
            },
          ),
        ),
        SizedBox(width: 10.h),
        Container(
          width: 62.h,
          padding: EdgeInsets.symmetric(vertical: 9.v),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomImageView(
                  imagePath: ImageConstant.imgSearch,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(right: 5.h),
                  onTap: () {
                    statusBottomSheet();
                  },
                ),
              ),
              Expanded(
                child: CustomImageView(
                  imagePath: ImageConstant.imgIconsFilterList,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(left: 5.h),
                  onTap: () {
                    statusBottomSheet();
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderCard(int index) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        color: const Color(0xFFF9FAFB),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _customField2(
                          viewModel.orderItemList[index].orderId ?? "id"),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey.shade400,
                          size: 5,
                        ),
                      ),
                      _customField2(
                          "${DateFormat("y MMM d").format(DateTime.parse(viewModel.orderItemList[index].createdAt ?? "now"))} at ${DateFormat("h:mm a").format(DateTime.parse(viewModel.orderItemList[index].createdAt ?? "now"))}"),
                    ],
                  ),
                  _customField2(viewModel
                              .orderItemList[index].orderDetails?.market !=
                          null
                      ? '${viewModel.orderItemList[index].orderDetails?.market!} Store'
                      : 'market'),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _customField1(
                            viewModel.orderItemList[index].customer?.name ??
                                "naaam"),
                        _customField1(
                            "Rs. ${viewModel.orderItemList[index].totals?.total?.toStringAsFixed(2) ?? "0"}"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(children: [
                        _status(viewModel.orderItemList[index].paymentStatus ??
                            "status"),
                        SizedBox(width: 8.h),
                        _status(
                            viewModel.orderItemList[index].fulfilmentStatus ??
                                "status")
                      ]),
                    ),
                    Obx(() => Row(
                          children: [
                            _customField2(
                                "${(viewModel.orderItemList[index].lineitems?.length) ?? "teeen"} items"),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey.shade400,
                                size: 5,
                              ),
                            ),
                            _customField2("Standard"),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8.v,
                        left: 8.h,
                        bottom: 16.v,
                      ),
                      child: _status("COD Verified"),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customField1(text1) {
    return CustomText(
      title: text1,
      style: TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _customField2(text) {
    return CustomText(
      title: text.toString(),
      style: TextStyle(
        fontSize: 12.fSize,
        color: ThemeHelper.grey4,
      ),
    );
  }

  Widget _status(
    String text,
  ) {
    Color color = statusColor(text);
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: const EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 6),
        decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Icon(
              Icons.circle_outlined,
              color: color,
              size: 10,
            ),
            SizedBox(width: 4.h),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color statusColor(String value) {
    switch (value) {
      case "Pending":
      case "Paid":
      case "Refunded":
      case "Unfulfilled":
        return const Color(0xFFFDBA8C);
      case "Partially Paid":
      case "Processing":
      case "Returned":
      case "In Transit":
      case "Out for Delivery":
        return const Color(0xFFFFE5A0);
      case "Cancelled":
      case "Failed":
        return const Color(0xFFFE3A30);
      case "Shipped":
      case "Fulfilled":
      case "Delivered":
      case "COD Verified":
        return const Color(0xFFBDE9DA);
      default:
        return const Color(0xFFFE3A30);
    }
  }

  statusBottomSheet() {
    int tempIndex = 0;
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: viewModel.statusSelectedIndex.value,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    tempIndex = index;
                  },
                  children: List.generate(
                    viewModel.statusList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.statusList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  viewModel.statusSelectedIndex.value = tempIndex;
                  viewModel.searchController.text =
                      viewModel.statusList[tempIndex];
                  viewModel.fieldSelection(viewModel.statusList[tempIndex]);

                  Get.back();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
