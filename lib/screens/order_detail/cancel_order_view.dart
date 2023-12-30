import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as lang_key;
import 'package:ismmart_vms/screens/order_listing/order_viewModel.dart';
import 'package:ismmart_vms/screens/product_list/product_model.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../helper/constants.dart';
import '../../helper/languages/translations_key.dart';
import '../../helper/utils/image_constant.dart';
import '../../widgets/appBar_leading_image.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text.dart';
import '../order_listing/model/orderModel.dart';

class CancelOrderView extends StatelessWidget {
  final OrderItem orderItems;
  //final OrderListingViewModel viewModel = Get.put(OrderListingViewModel());
  CancelOrderView({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 17.v),
              _buildOrderListFrame(),
              SizedBox(height: 17.v),
              progress(),
              SizedBox(height: 17.v),
              _buildOrderDetail(context, orderItems),
            ],
          ),
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
      title: lang_key.cancelOrder.tr,
    );
  }

  Widget _buildOrderListFrame() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Text("Order List"),
          CustomImageView(
            imagePath: ImageConstant.imgIconsArrowForward,
            // height: 18.adaptSize,
            // width: 8.adaptSize,
            margin: EdgeInsets.only(
              left: 8.adaptSize,
              right: 8.adaptSize,
            ),
          ),
          CustomText(
            title: "ISM1628MART".tr,
            style: TextStyle(
              fontSize: 10.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Delivery Status: ',
                        style: newFontStyleSize14,
                      ),
                      TextSpan(
                        text: 'Ready to Transit',
                        style: newFontStyleSize14.copyWith(
                            color: newColorLightGrey2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 0.5,
            backgroundColor: const Color(0xffEBEFF3),
            progressColor: newColorBlue,
            center: Text(
              "2 of 3",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(ctx, OrderItem orderItems) {
    return Container(
      width: MediaQuery.of(ctx).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField2(DateFormat.yMMMd()
                  .format(orderItems.createdAt ?? DateTime.now())),
              _customField2(
                  orderItems.orderDetails?.market.toString() ?? "market"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField1(orderItems.customer?.name.toString() ?? "name"),
              _customField1(orderItems.totals?.subTotal.toString() ?? "total"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            children: [
              _status(orderItems.items![0].paymentStatus ?? "status"),
              SizedBox(width: 8.h),
              _status(orderItems.items![1].fulfilmentStatus ?? "status"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            children: [
              _customField2("${orderItems.items?.length.toString()} items"),
              SizedBox(width: 8.h),
              _customField2("Standard")
            ],
          ),
          SizedBox(height: 10.v),
          _status("COD Verified"),
          SizedBox(height: 10.v),
          _customField1("Location"),
          SizedBox(height: 10.v),
          _customField2(
              "Plot No. 60, Street 12, G-8/1,Islamabad Capital Territory 44080\nPakistan"),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField1("Item list"),
              SizedBox(width: 8.h),
              _customField1(orderItems.items?.length.toString() ?? "length"),
            ],
          ),
          SizedBox(height: 10.v),
          Container(
            height: MediaQuery.of(ctx).size.height * 0.17,
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(8.v),
            decoration: BoxDecoration(
              color: Colors.yellow.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListView.builder(
              itemCount: orderItems.items?.length ?? 0,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customField1(
                            orderItems.items?[index].name ?? "product"),
                        _customField2(
                            orderItems.items?[index].vendor.toString() ?? "1"),
                        _customField2(
                            orderItems.items?[index].sku.toString() ?? "1"),
                        _customField2(
                            "Rs. ${orderItems.items?[index].totals?.total.toString()}  x ${orderItems.items?[index].qty?.toString()}"),
                      ],
                    ),
                    _customField1(
                        orderItems.items?[index].totals?.total.toString() ??
                            "total"),
                  ],
                );
              },
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Sub Total"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${orderItems.totals?.total.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Shipping Fee"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${orderItems.totals?.total.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Sales Tax"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${orderItems.totals?.total.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Promo Discount"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${orderItems.totals?.total.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Total Amount"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${orderItems.totals?.total.toString() ?? "0"}"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.v),
          _customField1("Item list"),
          SizedBox(height: 10.v),
          const Divider(),
          Container(
            height: MediaQuery.of(ctx).size.height * 0.17,
            width: MediaQuery.of(ctx).size.width * 1,
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(8.v),
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _status(orderItems.items?[0].fulfilmentStatus ?? "status"),
                SizedBox(height: 10.v),
                _customField2("Rider"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField1("Delivery Address"),
                    //SizedBox(width: 8.h),
                    _customField1("Change"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
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

  Widget _customField1(String text) {
    return CustomText(
      title: text,
      style: TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _status(String value) {
    Color color = statusColor(value);
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
              value,
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
    if (value == "Payment pending") {
      return const Color(0xFFFDBA8C);
    }
    if (value == "unfulfilled") {
      return const Color(0xFFFFE5A0);
    }
    if (value == "COD Verified") {
      return const Color(0xFFBDE9DA);
    } else {
      return const Color(0xFFFE3A30);
    }
  }

  onTapArrowLeft() {
    Get.back();
  }
}
