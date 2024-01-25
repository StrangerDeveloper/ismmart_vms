import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/Order/order_detail/order_detail_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_cached_network_image.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../helper/constants.dart';
import '../../../helper/utils/image_constant.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/loader_view.dart';
import '../order_cancel/cancel_order_view.dart';
import '../../return/return_view.dart';

// ignore: must_be_immutable
class OrderDetailView extends StatelessWidget {
  final OrderDetailViewModel viewModel = Get.put(OrderDetailViewModel());
  OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    child: _buildOrderListFrame(),
                  ),
                  progress(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: _buildOrderDetail(context),
                  ),
                  //logInBtn(),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return const CustomAppBar2(
      title: "Order Detail",
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          color: newColorLightGrey2,
                        ),
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

  Widget _buildOrderListFrame() {
    Map<String, String> statusTextMap = {
      "Unfulfilled": "Unfulfilled Orders",
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
    };
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: statusTextMap[
                    viewModel.orderItemModel.value.fulfilmentStatus] ??
                "",
            style: const TextStyle(
              color: ThemeHelper.blue1,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgIconsArrowForward,
            margin: EdgeInsets.only(
              left: 8.adaptSize,
              right: 8.adaptSize,
            ),
          ),
          CustomText(
            title: viewModel.orderItemModel.value.orderId ?? "id",
            style: newFontStyleSize12Grey2.copyWith(
              color: newColorLightGrey2,
            ),
          ),
          const Spacer(),
          PopupMenuButton(
            color: ThemeHelper.grey3,
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
              if (value == 1) {}
              if (value == 2) {
                bool hasUnfulfilledItem = viewModel.lineItemList
                    .any((item) => item.fulfilmentStatus == "Unfulfilled");

                if (hasUnfulfilledItem) {
                  Get.to(
                    () => CancelOrderView(),
                    arguments: {"model": viewModel.orderItemModel.value},
                  );
                } else {
                  AppConstant.displaySnackBar('Error',
                      'You can\'t cancel the order other than unfulfilled');
                  return;
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.v),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ThemeHelper.grey1,
                ),
              ),
              child: Row(
                children: [
                  CustomText(
                    title: "More actions",
                    style: newFontStyleSize12Grey2.copyWith(
                      color: newColorLightGrey2,
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
      ),
    );
  }

  Widget _buildFrame2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 9.v),
          margin: EdgeInsets.only(bottom: 20.v),
          width: MediaQuery.of(Get.context!).size.width * 1,
          decoration: BoxDecoration(
            color: ThemeHelper.grey3,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _customField1("Contact Information"),
              const SizedBox(height: 4),
              _customField2(
                  viewModel.orderItemModel.value.contactInfo?.email ?? "email"),
              _customField2(
                  viewModel.orderItemModel.value.contactInfo?.phone ?? "phone"),
              SizedBox(height: 12.v),
              _customField1("Shipping adress"),
              const SizedBox(height: 4),
              _customField2(
                  viewModel.orderItemModel.value.customer?.name ?? "name"),
              _customField2(
                  "${viewModel.orderItemModel.value.address?.shipping?.address ?? "address"}\n${viewModel.orderItemModel.value.address?.shipping?.city ?? "city"}, ${viewModel.orderItemModel.value.address?.shipping?.country ?? "country"}"),
              _customField2(
                  viewModel.orderItemModel.value.address?.shipping?.phone ??
                      "phone"),
              SizedBox(height: 12.v),
              _customField1("Billing adress"),
              const SizedBox(height: 4),
              _customField2(
                  viewModel.orderItemModel.value.customer?.name ?? "name"),
              _customField2(
                "${viewModel.orderItemModel.value.address?.billing?.address ?? "address"}\n${viewModel.orderItemModel.value.address?.billing?.city ?? "city"}, ${viewModel.orderItemModel.value.address?.billing?.country ?? "country"}",
              ),
              _customField2(
                  viewModel.orderItemModel.value.address?.billing?.phone ??
                      "phone"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _customField1(String text1) {
    return CustomText(
      title: text1,
      style: newFontStyle5,
    );
  }

  Widget _customField2(String text) {
    return CustomText(
      title: text,
      style: newFontStyleSize12Grey2.copyWith(
        color: newColorLightGrey3,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _customField3(String text1) {
    return CustomText(
      title: text1,
      style: newFontStyle5.copyWith(
        fontWeight: FontWeight.w200,
      ),
    );
  }

  Widget _status(String value) {
    Color color = statusColor(value);
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: const EdgeInsets.only(
          left: 4,
          top: 3,
          bottom: 3,
          right: 6,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.25),
          borderRadius: BorderRadius.circular(30),
        ),
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
        return const Color(0xFFFE3A30);
    }
  }

  Widget _buildOrderDetail(ctx) {
    return Obx(
      () => Container(
        width: MediaQuery.of(ctx).size.width * 1,
        decoration: BoxDecoration(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey.shade400,
                        size: 5,
                      ),
                    ),
                    _customField2(
                        "${DateFormat("y MMM d").format(DateTime.parse(viewModel.orderItemModel.value.createdAt!))} at ${DateFormat("h:mm a").format(DateTime.parse(viewModel.orderItemModel.value.createdAt!))}"),
                    SizedBox(width: 8.h),
                  ],
                ),
                _customField2(viewModel
                            .orderItemModel.value.orderDetails?.market !=
                        null
                    ? '${viewModel.orderItemModel.value.orderDetails?.market!} Store'
                    : 'market'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField1(viewModel.orderItemModel.value.customer?.name
                          .toString() ??
                      "name"),
                  _customField1(
                      "Rs. ${viewModel.orderItemModel.value.totals?.total?.toStringAsFixed(2) ?? "total"}"),
                ],
              ),
            ),
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
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Icon(
                    Icons.circle,
                    color: Colors.grey.shade400,
                    size: 5,
                  ),
                ),
                _customField2("Standard")
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: _status("COD Verified")),
            _customField1("Location"),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: _customField2(
                  "Plot No. 60, Street 12, G-8/1,Islamabad Capital Territory 44080\nPakistan"),
            ),
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
            const Divider(),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                color: ThemeHelper.grey3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField2("Order Tracking ID"),
                      _customField2(
                          viewModel.orderItemModel.value.orderId ?? "id"),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _status(viewModel.orderItemModel.value
                                        .lineitems?[index].fulfilmentStatus ??
                                    "status"),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CustomCachedNetworkImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: viewModel.orderItemModel.value
                                            .lineitems![index].media!,
                                        boxShape: BoxShape.rectangle,
                                        assetsImage: const AssetImage(
                                            'assets/images/image_not_found.png')),
                                    SizedBox(width: 16.h),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _customField1(viewModel.orderItemModel
                                                .value.lineitems?[index].name ??
                                            "product"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6.0, bottom: 4.0),
                                          child: _customField2(viewModel
                                                  .orderItemModel.value.orderId
                                                  ?.toString() ??
                                              "id"),
                                        ),
                                        _customField2(
                                            "SKU: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "1"}"),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 56.0),
                                  child: _customField2(
                                      "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total.toString()}  x ${viewModel.orderItemModel.value.lineitems?[index].qty?.toString()}"),
                                ),
                                SizedBox(
                                  height: 12.h,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 26.0),
                              child: _customField1(
                                  "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total?.toStringAsFixed(2) ?? "total"}"),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: ThemeHelper.grey3,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField3("Sub Total"),
                      SizedBox(width: 8.h),
                      _customField2(
                          "Rs. ${viewModel.orderItemModel.value.totals?.subTotal?.toStringAsFixed(2) ?? "0"}"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _customField3("Shipping Fee"),
                        SizedBox(width: 8.h),
                        _customField2(
                            "Rs. ${viewModel.orderItemModel.value.totals?.shipping?.toStringAsFixed(2) ?? "0"}"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField3("Sales Tax"),
                      SizedBox(width: 8.h),
                      _customField2(
                          "Rs. ${viewModel.orderItemModel.value.totals?.tax?.toStringAsFixed(2) ?? "0"}"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _customField3("Promo Discount"),
                        SizedBox(width: 8.h),
                        _customField2(
                            "Rs. ${viewModel.orderItemModel.value.totals?.discount?.toStringAsFixed(2) ?? "0"}"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField3("Total Amount"),
                      SizedBox(width: 8.h),
                      _customField2(
                          "Rs. ${viewModel.orderItemModel.value.totals?.total?.toStringAsFixed(2) ?? "0"}"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 17.v),
            _customField1("Delivery Details"),
            const Divider(),
            Container(
              height: MediaQuery.of(ctx).size.height * 0.17,
              width: MediaQuery.of(ctx).size.width * 1,
              padding: EdgeInsets.all(8.h),
              margin: EdgeInsets.only(top: 8.v),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _status(viewModel.orderItemModel.value.fulfilmentStatus ??
                      "status"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: _customField2("Rider"),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: _customField2("Delivery Method"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "rider"),
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
      child: CustomRoundedTextBtn(
        child: const Text(
          "Accept",
        ),
        onPressed: () {
          Get.to(RefundView());
        },
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }
}
