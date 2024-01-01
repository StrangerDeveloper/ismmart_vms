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
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          //color: Colors.grey.shade200,
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
              SizedBox(height: 10.v),
              _buildOrderDetail(context, order),
              SizedBox(height: 10.v),
              logInBtn(),
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
      title: lang_key.orderDetail.tr,
    );
  }

  Widget progress() {
    return Row(
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
                      text: order.deliveryStatus ?? "status",
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
    );
  }

  Widget _buildOrderListFrame() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Order List"),
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
              Get.to(() => CancelOrderView(), arguments: {"model": order});
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
                              _customField2(
                                  order.contactInfo?.email ?? "email"),
                              _customField2(
                                  order.contactInfo?.phone ?? "phone"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      _customField1("Shipping adress"),
                      _customField2(order.customer?.name ?? "name"),
                      _customField2(
                          "${order.address!.shipping!.address!}\n${order.address!.shipping!.city!}, ${order.address!.shipping!.country!}"),
                      _customField2(order.address!.shipping!.phone ?? "phone"),
                      SizedBox(height: 8.v),
                      _customField1("Billing adress"),
                      _customField2(order.customer?.name ?? "name"),
                      _customField2(
                          "${order.address!.billing!.address!}\n${order.address!.billing!.city!}, ${order.address!.billing!.country!}"),
                      _customField2(order.address!.billing!.phone ?? "phone"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.v),
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

  Widget _buildOrderDetail(ctx, OrderItem order) {
    return Container(
      width: MediaQuery.of(ctx).size.width * 1,
      decoration: BoxDecoration(
        //color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _customField2(order.orderId ?? "id"),
                  SizedBox(width: 8.h),
                  Icon(
                    Icons.circle,
                    color: Colors.grey.shade400,
                    size: 5,
                  ),
                  SizedBox(width: 8.h),
                  _customField2(DateFormat.yMMMd().format(DateTime.parse(
                      order.createdAt ?? "2021-09-09T09:09:09.000Z"))),
                  SizedBox(width: 8.h),
                ],
              ),
              _customField2(order.orderDetails?.market.toString() ?? "market"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField1(order.customer?.name.toString() ?? "name"),
              _customField1(order.totals?.total.toString() ?? "total"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            children: [
              _status(order.paymentStatus ?? "status"),
              SizedBox(width: 8.h),
              _status(order.fulfilmentStatus ?? "status"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            children: [
              _customField2("${order.lineitems?.length.toString()} items"),
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
          _buildFrame2(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField1("Item list"),
              SizedBox(width: 8.h),
              _customField1(order.lineitems?.length.toString() ?? "length"),
            ],
          ),
          SizedBox(height: 10.v),
          Container(
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(8.v),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.lineitems?.length ?? 0,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              order.lineitems?[index].media ?? "image"),
                        ),
                        SizedBox(width: 10.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _customField1(
                                order.lineitems?[index].name ?? "product"),
                            _customField2(
                                "SKU: ${order.lineitems?[index].sku.toString() ?? "1"}"),
                            _customField2(
                                "Rs. ${order.lineitems?[index].totals?.total.toString()}  x ${order.lineitems?[index].qty?.toString()}"),
                            SizedBox(
                              height: 12.h,
                            )
                          ],
                        ),
                      ],
                    ),
                    _customField1(
                        order.lineitems?[index].totals?.total.toString() ??
                            "total"),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 10.v),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Sub Total"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${order.totals?.subTotal.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Shipping Fee"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${order.totals?.shipping.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Sales Tax"),
                  SizedBox(width: 8.h),
                  _customField2("Rs. ${order.totals?.tax.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Promo Discount"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${order.totals?.discount.toString() ?? "0"}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Total Amount"),
                  SizedBox(width: 8.h),
                  _customField2("Rs. ${order.totals?.total.toString() ?? "0"}"),
                ],
              ),
            ],
          ),
          SizedBox(height: 17.v),
          _customField1("Delivery Status"),
          const Divider(),
          Container(
            height: MediaQuery.of(ctx).size.height * 0.17,
            width: MediaQuery.of(ctx).size.width * 1,
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(8.v),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _status(order.fulfilmentStatus ?? "status"),
                SizedBox(height: 10.v),
                _customField2("Rider"),
                SizedBox(height: 5.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField1(
                        "${order.lineitems?[0].assignedRider?.name ?? "rider"}"),
                    _customField1(
                        order.lineitems?[0].assignedRider?.cnic ?? "id"),
                  ],
                ),
                SizedBox(height: 10.v),
                _customField2("Delivery Method"),
                SizedBox(height: 5.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField1(
                        "${order.lineitems?[0].assignedRider?.name ?? "rider"}"),
                    //SizedBox(width: 8.h),
                    _customField1(order.deliveryStatus ?? "id"),
                  ],
                ),
              ],
            ),
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
                child: const Text(
                  "Accept",
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
