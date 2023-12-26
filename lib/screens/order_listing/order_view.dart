import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_listing/model/order_model.dart';
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
  OrderView({super.key}) {
    Get.put(OrderViewModel()).fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    final OrderViewModel orderController = Get.find<OrderViewModel>();

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 17.v),
            _buildSearchRow(),
            SizedBox(height: 17.v),
            Obx(
              () => orderController.orders.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderController.orders.length,
                            itemBuilder: (context, index) {
                              final detail = orderController.orders[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => OrderDetailView(order: detail));
                                },
                                child: _buildOrderCard(detail),
                              );
                            },
                          ),
                          //const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Expanded(
                          //       child: ElevatedButton.icon(
                          //         onPressed: () {
                          //           // Get.to(() => AddOrderView());
                          //         },
                          //         icon: const Icon(Icons.add),
                          //         label: const Text('Add Order'),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
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
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 24.h, top: 10.v, bottom: 10.v),
        onTap: () {
          onTapArrowLeft();
        },
      ),
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

  Widget _buildOrderCard(Order detail) {
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
                _customField2("12 Decemeber 2023"),
                _customField2("Online Store"),
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
                      _customField1(detail.customerName),
                      _customField1(detail.amount.toString()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        _status("Payment pending", "1"),
                        SizedBox(width: 8.h),
                        _status(detail.fulfillmentStatus, "2"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _customField2("4 items"),
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
                    child: _status("COD Verified", "3"),
                  ),
                ],
              ),
            ),
            // _buildOrderCardContent("Order ID", detail.orderId.toString()),
            // _buildOrderCardContent("Customer Name", detail.customerName),
            // _buildOrderCardContent("Date", detail.date.toString()),
            // _buildOrderCardContent(
            //     "Fulfillment Status", detail.fulfillmentStatus),
            // _buildOrderCardContent("Total Amount", detail.amount.toString()),
          ],
        ),
      ),
    );
  }

  Widget _customField1(String text1) {
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

  Widget _customField2(String text) {
    return CustomText(
      title: text,
      style: TextStyle(
        fontSize: 12.fSize,
        color: const Color(0xFF6B7280),

        ///fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _status(String text, String value) {
    Color color = statusColor(value);
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
    if (value == '1') {
      return const Color(0xFFFDBA8C);
    }
    if (value == '2') {
      return const Color(0xFFFFE5A0);
    }
    if (value == '3') {
      return const Color(0xFFBDE9DA);
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  Widget _buildOrderCardContent(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title: "$title:"),
          CustomText(
            title: value,
          ),
        ],
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }
}
