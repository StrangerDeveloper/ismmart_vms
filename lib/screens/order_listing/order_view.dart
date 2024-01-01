import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_listing/model/orderModel.dart';
import 'package:ismmart_vms/screens/order_listing/order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_bottom_sheet.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:ismmart_vms/widgets/custom_textfield.dart';

import '../../helper/utils/image_constant.dart';
import '../../widgets/appBar_leading_image.dart';
import '../../widgets/custom_image_view.dart';
import '../order_detail/order_detail_view.dart';

class OrderView extends StatelessWidget {
  final OrderListingViewModel orderController =
      Get.put(OrderListingViewModel());

  OrderView({super.key}) {
    //Get.put(OrderListingViewModel()).getOrderListing();
  }

  // initState() {
  //   Get.put(OrderListingViewModel()).getOrderListing();
  //   orderController.isLoading.value = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 17.v),
            _buildSearchRow(),
            SizedBox(height: 17.v),
            Obx(
              () => orderController.orderItemList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              controller: orderController.scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderController.orderItemList.length,
                              itemBuilder: (context, index) {
                                OrderItem orderItems =
                                    orderController.orderItemList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => OrderDetailView(
                                          order: orderItems,
                                        ));
                                  },
                                  child: _buildOrderCard(orderItems),
                                );
                              },
                            ),
                          ]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: Container(),
      // leading: AppbarLeadingImage(
      //   imagePath: ImageConstant.imgArrowLeft,
      //   margin: EdgeInsets.only(left: 24.h, top: 10.v, bottom: 10.v),
      //   onTap: () {
      //     onTapArrowLeft();
      //   },
      // ),
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
            //title: 'Status',
            filled: false,
            hintText: 'Search',
            //readOnly: true,
            isDropDown: true,
            onTap: () {
              CustomBottomSheet1(
                list: ['All', 'Pending', 'Completed', 'Cancelled'],
                selectedIndex: 0,
                onChanged: (int index) {},
              ).show();
            },
          ),
        ),
        SizedBox(width: 10.h),
        Container(
          width: 62.h,
          //margin: EdgeInsets.only(left: 16.h, right: 10.h),
          padding: EdgeInsets.symmetric(vertical: 9.v),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          // decoration: AppDecoration.outlineGray
          //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: CustomImageView(
                      imagePath: ImageConstant.imgSearch,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(right: 5.h))),
              Expanded(
                child: CustomImageView(
                  imagePath: ImageConstant.imgIconsFilterList,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(left: 5.h),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderCard(OrderItem orderItemDetail) {
    print("details ${orderItemDetail.toJson()}");
    return Card(
      color: const Color(0xFFF9FAFB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customField2(DateFormat.yMMMd()
                    .format(DateTime.parse(orderItemDetail.createdAt!))),
                _customField2(orderItemDetail.orderDetails?.market.toString() ??
                    "market"),
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
                      _customField1(orderItemDetail.customer?.name ?? "naaam"),
                      _customField1("${orderItemDetail.totals?.total ?? "0"}"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _status(orderItemDetail.paymentStatus ?? "status"),
                    // child: ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: orderItemDetail.lineitems?.length ?? 0,
                    //   itemBuilder: (context, index) {
                    //     Lineitem lineitems = orderItemDetail.lineitems![index];
                    //     return Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         _status(lineitems.paymentStatus ?? "asdf"),
                    //         // _customField2(lineitems.name ?? "name"),
                    //         // _customField2(lineitems.quantity.toString() ?? "0"),
                    //         // _customField2(lineitems.total.toString() ?? "0"),
                    //       ],
                    //     );
                    //   },
                    // ),
                    // child: Row(
                    //   children: orderItemDetail.lineitems!
                    //       .map((e) => _status(e.fulfilmentStatus!))
                    //       .toList(),

                    //   // _status("Payment pending", "1"),
                    //   // SizedBox(width: 8.h),
                    //   // _status(detail.items, "2"),
                    // ),
                  ),
                  Row(
                    children: [
                      _customField2(
                          "${orderItemDetail.lineitems?.length ?? "teeen"} items"),
                      SizedBox(width: 8.h),
                      Icon(
                        Icons.circle,
                        color: Colors.grey.shade400,
                        size: 5,
                      ),
                      SizedBox(width: 8.h),
                      _customField2("Standard"),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.v, left: 8.h),
                    child: _status("COD Verified"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customField1(text1) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: text1,
          style: TextStyle(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _customField2(text) {
    return CustomText(
      title: text.toString(),
      style: TextStyle(
        fontSize: 12.fSize,
        color: const Color(0xFF6B7280),

        ///fontWeight: FontWeight.w600,
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
        //margin: const EdgeInsets.only(left: 10),
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
    if (value == "Pending") {
      return const Color(0xFFFDBA8C);
    }
    if (value == "Paid") {
      return const Color(0xFFFDBA8C);
    }
    if (value == "Partially Paid") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "Refunded") {
      return const Color(0xFFFDBA8C);
    }
    if (value == "Cancelled") {
      return const Color(0xFFFE3A30);
    }
    if (value == "Processing") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "Shipped") {
      return const Color(0xFFBDE9DA);
    }
    if (value == "Delivered") {
      return const Color(0xFFBDE9DA);
    }
    if (value == "Returned") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "In Transit") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "Out for Delivery") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "Failed") {
      return const Color(0xFFFE3A30);
    }
    if (value == "COD Verified") {
      return const Color(0xFFBDE9DA);
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  // onTapArrowLeft() {
  //   Get.back();
  // }
}
