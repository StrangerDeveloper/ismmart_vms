import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as lang_key;
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_detail/cancel_order_view.dart';
import 'package:ismmart_vms/screens/order_listing/model/orderModel.dart';
import 'package:ismmart_vms/screens/order_listing/order_view.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../helper/utils/image_constant.dart';
import '../../widgets/appBar_leading_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_loading.dart';
import '../return/return_view.dart';

// ignore: must_be_immutable
class OrderDetailView extends StatelessWidget {
  final OrderItem order;
  OrderDetailView({super.key, required this.order}) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFrame(),
                  SizedBox(height: 16.v),
                  progress(),
                  _buildFrame2(),
                  _buildOrderTracking(order),
                  logInBtn(),
                ],
              ),
            ),
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
      title: lang_key.orderDetail.tr,
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
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

  Widget _buildFrame() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.v),
          child: CustomText(
            title: "Order List",
            style: TextStyle(
              fontSize: 12.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgIconsArrowForward,
          height: 8.adaptSize,
          width: 8.adaptSize,
          margin: EdgeInsets.only(
            left: 4.h,
            top: 12.v,
            bottom: 12.v,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h, top: 8.v, bottom: 8.v),
          child: CustomText(
            title: "ISM1628MART".tr,
            style: TextStyle(
              fontSize: 10.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  const Icon(Icons.download_outlined),
                  SizedBox(width: 8.h),
                  const Text(
                    "Export",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  const Icon(Icons.cancel_outlined),
                  SizedBox(width: 8.h),
                  const Text(
                    "Cancel Order",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {
              Get.to(OrderView());
            }
            if (value == 2) {
              Get.to(CancelOrderView(
                orderItems: order,
              ));
            }
          },
          child: Container(
            //margin: EdgeInsets.only(right: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.v),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                CustomText(
                  title: "More actions",
                  style: TextStyle(
                    fontSize: 12.fSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  size: 16.fSize,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrame2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Multi vendor".tr,
        ),
        SizedBox(height: 8.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _customField2(
                DateFormat.yMMMd().format(order.createdAt ?? DateTime.now())),
            _customField2(order.orderDetails?.market.toString() ?? "market"),
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
                  _customField1(order.customer?.name.toString() ?? "name"),
                  //_customField1(order.totals?.total.toString() ?? "total"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    _status("Payment pending"),
                    SizedBox(width: 8.h),
                    _status("unfulfilled"),
                  ],
                ),
              ),
              Row(
                children: [
                  _customField2("${order.lineitems?.length.toString()} items"),
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
        SizedBox(height: 8.v),
        _customField1("Location"),
        SizedBox(height: 5.v),
        _customField2(
            "Plot No. 60, Street 12, G-8/1,Islamabad Capital Territory 44080 Pakistan"),
        SizedBox(height: 8.v),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 7.v),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _customField1("Contact Information"),
                              _customField2("No email provided"),
                              _customField2("+92 333 1234567"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      _customField1("Shipping adress"),
                      _customField2("Shehzad Khan"),
                      _customField2(
                          "${order.address!.shipping!.address!}\n${order.address!.shipping!.city!}, ${order.address!.shipping!.country!}"),
                      _customField2("+92 333 1234567"),
                      SizedBox(height: 8.v),
                      _customField1("Billing adress"),
                      _customField2("Shehzad Khan"),
                      _customField2(
                          "${order.address!.billing!.address!}\n${order.address!.billing!.city!}, ${order.address!.billing!.country!}"),
                      _customField2("+92 333 1234567"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _customField1("Item list"),
            _customField1(order.lineitems?.length.toString() ?? "length"),
          ],
        ),
        const Divider(),
        SizedBox(height: 12.v),
      ],
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

  Widget _buildOrderTracking(OrderItem order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(left: 8.h, right: 8.v, top: 8.v, bottom: 8.v),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: order.lineitems?.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: order.lineitems![index].media?.length,
                    itemBuilder: (context, index2) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              order.lineitems?[index].media?[index2] ??
                                  "image"),
                        ),
                        title: Text(
                          order.lineitems![index].name ?? "",
                        ),
                        // subtitle: Text(
                        //   order.lineitems?[index].vendor ?? "",
                        // ),
                        trailing: Text(
                          "Rs. ${order.lineitems?[index].totals?.total.toString()}",
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text(
                      "Rs. ${order.lineitems?[index].totals?.total.toString()}  x ${order.lineitems?[index].qty?.toString()}",
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   "Rs. ${order.totals?.total.toString()}",
                      //   style: TextStyle(
                      //     fontSize: 12.fSize,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   "Rs. ${order.totals?.coupon.toString()}",
                      //   style: TextStyle(
                      //     fontSize: 12.fSize,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: TextStyle(
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   "Rs. ${order.totals?.coupon.toString()}",
                      //   style: TextStyle(
                      //     fontSize: 12.fSize,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Promo Discount",
                        style: TextStyle(
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   "Rs. ${order.totals?.coupon.toString()}",
                      //   style: TextStyle(
                      //     fontSize: 12.fSize,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text(
                      //   "Rs. ${order.totals?.coupon.toString()}",
                      //   style: TextStyle(
                      //     fontSize: 12.fSize,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget logInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                backgroundColor: Colors.deepPurple,
                child: const Text(
                  "Return",
                  //style: newFontStyle3,
                ),
                onPressed: () {
                  Get.to(RefundView());
                },
              ),
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }
}
