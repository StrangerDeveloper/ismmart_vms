import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as lang_key;
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_detail/cancel_order_view.dart';
import 'package:ismmart_vms/screens/order_detail/order_detail_viewModel.dart';
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
  final OrderDetailViewModel viewModel = Get.put(OrderDetailViewModel());
  OrderDetailView({super.key});

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
              _buildOrderDetail(context),
              SizedBox(height: 10.v),
              logInBtn(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar2(
      title: "Order Detail",
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
                      text: viewModel.orderItemModel.value.deliveryStatus ??
                          "status",
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
    Map<String, String> statusTextMap = {
      "Unfulfilled": "Unfulfilled Order List",
      "Fulfilled": "Fulfilled Order List",
      "Cancelled": "Cancelled Order List",
      "Returned": "Returned Order List",
      "In Transit": "In Transit Order List",
      "Out for Delivery": "Out for Delivery",
      "Delivered": "Delivered Order List",
      "COD Verified": "COD Verified",
      "Processing": "Processing",
      "Shipped": "Shipped Order List",
      "Failed": "Failed Order List",
      "Paid": "Paid Order List",
      "Refunded": "Refunded Order List",
      "Partially Paid": "Partially Paid",
      "Pending": "Pending Order List",
      // Repeat values are removed as they have the same text
    };

    String statusText =
        statusTextMap[viewModel.orderItemModel.value.fulfilmentStatus] ?? "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: statusText,
          style: const TextStyle(color: ThemeHelper.blue1),
        ),
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
              bool hasUnfulfilledItem = viewModel.lineItemList
                  .any((item) => item.fulfilmentStatus == "Unfulfilled");

              if (hasUnfulfilledItem) {
                Get.to(() => CancelOrderView(),
                    arguments: {"model": viewModel.orderItemModel.value});
              } else {
                AppConstant.displaySnackBar('Error',
                    'You can\'t cancel the order other than unfulfilled');
                return;
              }
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
                              _customField2(viewModel.orderItemModel.value
                                      .contactInfo?.email ??
                                  "email"),
                              _customField2(viewModel.orderItemModel.value
                                      .contactInfo?.phone ??
                                  "phone"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      _customField1("Shipping adress"),
                      _customField2(
                          viewModel.orderItemModel.value.customer?.name ??
                              "name"),
                      _customField2(
                          "${viewModel.orderItemModel.value.address!.shipping!.address!}\n${viewModel.orderItemModel.value.address!.shipping!.city!}, ${viewModel.orderItemModel.value.address!.shipping!.country!}"),
                      _customField2(viewModel
                              .orderItemModel.value.address!.shipping!.phone ??
                          "phone"),
                      SizedBox(height: 8.v),
                      _customField1("Billing adress"),
                      _customField2(
                          viewModel.orderItemModel.value.customer?.name ??
                              "name"),
                      _customField2(
                          "${viewModel.orderItemModel.value.address!.billing!.address!}\n${viewModel.orderItemModel.value.address!.billing!.city!}, ${viewModel.orderItemModel.value.address!.billing!.country!}"),
                      _customField2(viewModel
                              .orderItemModel.value.address!.billing!.phone ??
                          "phone"),
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
    return CustomText(
      title: text1,
      style: TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
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
        return const Color(0xFFFE3A30); // Default color for unknown statuses
    }
  }

  Widget _buildOrderDetail(ctx) {
    return Obx(
      () => Container(
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
                    _customField2(
                        viewModel.orderItemModel.value.orderId ?? "id"),
                    SizedBox(width: 8.h),
                    Icon(
                      Icons.circle,
                      color: Colors.grey.shade400,
                      size: 5,
                    ),
                    SizedBox(width: 8.h),
                    _customField2(DateFormat.yMMMd().format(DateTime.parse(
                        viewModel.orderItemModel.value.createdAt ??
                            "2021-09-09T09:09:09.000Z"))),
                    SizedBox(width: 8.h),
                  ],
                ),
                _customField2(viewModel
                        .orderItemModel.value.orderDetails?.market
                        .toString() ??
                    "market"),
              ],
            ),
            SizedBox(height: 10.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customField1(
                    viewModel.orderItemModel.value.customer?.name.toString() ??
                        "name"),
                _customField1(
                    viewModel.orderItemModel.value.totals?.total.toString() ??
                        "total"),
              ],
            ),
            SizedBox(height: 10.v),
            Row(
              children: [
                _status(
                    viewModel.orderItemModel.value.paymentStatus ?? "status"),
                SizedBox(width: 8.h),
                _status(viewModel.orderItemModel.value.fulfilmentStatus ??
                    "status"),
              ],
            ),
            SizedBox(height: 10.v),
            Row(
              children: [
                _customField2(
                    "${viewModel.orderItemModel.value.lineitems?.length.toString()} items"),
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
                _customField1(viewModel.orderItemModel.value.lineitems?.length
                        .toString() ??
                    "length"),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField2("Order Tracking ID"),
                      _customField2(viewModel.orderItemModel.value.sId ?? "id"),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          viewModel.orderItemModel.value.lineitems?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(viewModel
                                          .orderItemModel
                                          .value
                                          .lineitems?[index]
                                          .media ??
                                      "image"),
                                ),
                                SizedBox(width: 10.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        _customField1(viewModel.orderItemModel
                                                .value.lineitems?[index].name ??
                                            "product"),
                                        SizedBox(width: 8.h),
                                        _status(viewModel
                                                .orderItemModel
                                                .value
                                                .lineitems?[index]
                                                .fulfilmentStatus ??
                                            "status")
                                      ],
                                    ),
                                    _customField2(
                                        "SKU: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "1"}"),
                                    _customField2(
                                        "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total.toString()}  x ${viewModel.orderItemModel.value.lineitems?[index].qty?.toString()}"),
                                    SizedBox(
                                      height: 12.h,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            _customField1(viewModel.orderItemModel.value
                                    .lineitems?[index].totals?.total
                                    .toString() ??
                                "total"),
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
                        "Rs. ${viewModel.orderItemModel.value.totals?.subTotal.toString() ?? "0"}"),
                  ],
                ),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Shipping Fee"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.shipping.toString() ?? "0"}"),
                  ],
                ),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Sales Tax"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.tax.toString() ?? "0"}"),
                  ],
                ),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Promo Discount"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.discount.toString() ?? "0"}"),
                  ],
                ),
                SizedBox(height: 8.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Total Amount"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.total.toString() ?? "0"}"),
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
                  _status(viewModel.orderItemModel.value.fulfilmentStatus ??
                      "status"),
                  SizedBox(height: 10.v),
                  _customField2("Rider"),
                  SizedBox(height: 5.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "rider"),
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.cnic ??
                          "id"),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  _customField2("Delivery Method"),
                  SizedBox(height: 5.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "rider"),
                      //SizedBox(width: 8.h),
                      _customField1(
                          viewModel.orderItemModel.value.deliveryStatus ??
                              "id"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
