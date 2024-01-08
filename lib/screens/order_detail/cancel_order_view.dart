import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_detail/cancel_order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../helper/constants.dart';
import '../../helper/utils/image_constant.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loader_view.dart';

class CancelOrderView extends StatelessWidget {
  final CancelORderViewMOdel viewModel = Get.put(CancelORderViewMOdel());
  CancelOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Obx(
            () => Container(
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
                      padding: const EdgeInsets.only(top: 17.0, bottom: 17.0),
                      child: _buildOrderListFrame(),
                    ),
                    progress(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: _buildOrderDetail(context),
                    ),
                    _acceptBtn(context),
                  ],
                ),
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
      title: "Cancel Order",
    );
  }

  Widget _buildOrderListFrame() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          const Text("Order List",
              style: TextStyle(fontSize: 16, color: ThemeHelper.blue1)),
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
            title: viewModel.orderItemModel.value.orderId ?? "id",
            style: TextStyle(
              fontSize: 12.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Delivery Status: ',
                    style: newFontStyleSize14,
                  ),
                  TextSpan(
                    text: viewModel.orderItemModel.value.deliveryStatus ??
                        "status",
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey2),
                  ),
                ],
              ),
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

  Widget _buildOrderDetail(ctx) {
    return Container(
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
              _customField2(DateFormat.yMMMd().format(
                  DateTime.parse(viewModel.orderItemModel.value.createdAt!))),
              _customField2(
                  viewModel.orderItemModel.value.orderDetails?.market ??
                      "market"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customField1(
                    viewModel.orderItemModel.value.customer?.name.toString() ??
                        "name"),
                _customField1(
                    viewModel.orderItemModel.value.totals?.total ?? "total"),
              ],
            ),
          ),
          Row(
            children: [
              _status(viewModel.orderItemModel.value.paymentStatus ?? "status"),
              SizedBox(width: 8.h),
              _status(
                  viewModel.orderItemModel.value.fulfilmentStatus ?? "status"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Obx(() => Row(
                  children: [
                    _customField2(
                        "${viewModel.orderItemModel.value.lineitems?.length.toString() ?? 0} items"),
                    SizedBox(width: 8.h),
                    _customField2("Standard")
                  ],
                )),
          ),
          _status("COD Verified"),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: _customField1("Location"),
          ),
          _customField2(
              "Plot No. 60, Street 12, G-8/1,Islamabad Capital Territory 44080\nPakistan"),
          SizedBox(height: 12.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _customField1("Item list"),
              SizedBox(width: 8.h),
              _customField1(
                  viewModel.orderItemModel.value.lineitems?.length.toString() ??
                      "length"),
            ],
          ),
          const Divider(),
          CustomTextBtn(
            backgroundColor: Colors.transparent,
            foregroundColor: ThemeHelper.blue1,
            width: double.minPositive,
            onPressed: () {
              viewModel.selectAllItems();
            },
            child: const Text(
              "Select All",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: ThemeHelper.grey1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Order Tracking ID"),
                    _customField2(
                        viewModel.orderItemModel.value.sId ?? "orderId"),
                  ],
                ),
                SizedBox(height: 10.v),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.unfulfilledItems.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Checkbox(
                              value: viewModel
                                      .unfulfilledItems[index].isSelected ??
                                  false,
                              onChanged: (value) {
                                viewModel.selectSingleItem(value!, index);
                                if (value) {
                                  viewModel.selectedItems
                                      .add(viewModel.unfulfilledItems[index]);
                                } else {
                                  viewModel.selectedItems.remove(
                                      viewModel.unfulfilledItems[index]);
                                }
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                viewModel.unfulfilledItems[index].media ??
                                    "image"),
                          ),
                          SizedBox(width: 8.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _customField1(viewModel
                                            .unfulfilledItems[index].name ??
                                        "product"),
                                    SizedBox(width: 8.h),
                                    _status(viewModel.unfulfilledItems[index]
                                            .fulfilmentStatus ??
                                        "status")
                                  ],
                                ),
                                _customField2(
                                    viewModel.unfulfilledItems[index].sku ??
                                        'N/A'),
                                _customField2(
                                    "Rs. ${viewModel.unfulfilledItems[index].totals?.total ?? 0}  x ${viewModel.unfulfilledItems[index].qty ?? 0}"),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          ),
                          _customField1(
                              viewModel.unfulfilledItems[index].totals?.total ??
                                  0),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Sub Total"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.subTotal ?? 0}"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField2("Shipping Fee"),
                      SizedBox(width: 8.h),
                      _customField2(
                          "Rs. ${viewModel.orderItemModel.value.totals?.shipping ?? 0}"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Sales Tax"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.tax ?? 0}"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField2("Promo Discount"),
                      SizedBox(width: 8.h),
                      _customField2(
                          "Rs. ${viewModel.orderItemModel.value.totals?.discount ?? 0}"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField2("Total Amount"),
                    SizedBox(width: 8.h),
                    _customField2(
                        "Rs. ${viewModel.orderItemModel.value.totals?.total ?? 0}"),
                  ],
                ),
              ],
            ),
          ),
          CustomText(
            title: "Selected Item list",
            style: TextStyle(
              fontSize: 16.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.v),
          Container(
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(8.v),
            decoration: BoxDecoration(
              color: ThemeHelper.grey1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (viewModel.selectedItems.length),
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              viewModel.selectedItems[index].media ?? "image"),
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _customField1(
                                  viewModel.selectedItems[index].name ??
                                      "product"),
                              _customField2(
                                  viewModel.selectedItems[index].sku ?? 'N/A'),
                              _customField2(
                                  "Rs. ${viewModel.selectedItems[index].totals?.total ?? 0}  x ${viewModel.selectedItems[index].qty ?? 0}"),
                              const SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                        _customField1(
                            viewModel.selectedItems[index].totals?.total ?? 0),
                      ],
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _customField2(text) {
    return CustomText(
      title: text.toString(),
      style: TextStyle(
        fontSize: 12.fSize,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _customField1(text) {
    return CustomText(
      title: text.toString(),
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

  Widget _acceptBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      child: CustomRoundedTextBtn(
        child: const Text(
          "Cancel Order",
        ),
        onPressed: () {
          if (viewModel.selectedItems.isEmpty) {
            AppConstant.displaySnackBar(
                'Error', 'Please select at least one item');
            return;
          }
          bool isFulfilled = viewModel.selectedItems.any((element) =>
              element.fulfilmentStatus == "Fulfilled" ||
              element.fulfilmentStatus == "Partially Fulfilled" ||
              element.fulfilmentStatus == "Cancelled" ||
              element.fulfilmentStatus == "Returned" ||
              element.fulfilmentStatus == "Refunded");
          if (isFulfilled == true) {
            AppConstant.displaySnackBar(
                'Error', 'You cannot cancel fulfilled items');
            return;
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Cancel Order"),
                  content: Obx(() => Text(
                      "Are you sure you want to cancel them item from Order # ${viewModel.orderItemModel.value.orderId} ?")),
                  actions: [
                    CustomTextBtn(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: ThemeHelper.blue1,
                      onPressed: () {
                        Get.back();
                      },
                      title: "Cancel",
                    ),
                    CustomTextBtn(
                      onPressed: () async {
                        Get.back();
                        await viewModel.updateOrder();
                      },
                      title: "Confirm",
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  onTapArrowLeft() {
    viewModel.orderItemModel.value.lineitems?.forEach((element) {
      element.isSelected = false;
    });
    viewModel.selectedItems.refresh();
    viewModel.selectAllValue.value = false;
    viewModel.lineItemList.clear();
    viewModel.lineItemList.refresh();
    Get.back();
  }
}
