import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as lang_key;
import 'package:ismmart_vms/screens/order_detail/cancel_order_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../helper/constants.dart';
import '../../helper/utils/image_constant.dart';
import '../../widgets/appBar_leading_image.dart';
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
                      SizedBox(height: 17.v),
                      _buildOrderDetail(context),
                      SizedBox(height: 10.v),
                      _acceptBtn(context),
                    ],
                  ),
                ),
              ),
            ),
            const LoaderView(),
          ],
        ));
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
    return Row(
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
      ],
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

  Widget _buildOrderDetail(ctx) {
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
              _customField2(DateFormat.yMMMd().format(
                  DateTime.parse(viewModel.orderItemModel.value.createdAt!))),
              _customField2(
                  viewModel.orderItemModel.value.orderDetails?.market ??
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
                  viewModel.orderItemModel.value.totals?.total ?? "total"),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            children: [
              _status(
                  viewModel.orderItemModel.value.lineitems![0].paymentStatus ??
                      "status"),
              SizedBox(width: 8.h),
              _status(viewModel
                      .orderItemModel.value.lineitems![1].fulfilmentStatus ??
                  "status"),
            ],
          ),
          SizedBox(height: 10.v),
          Obx(() => Row(
                children: [
                  _customField2(
                      "${viewModel.orderItemModel.value.lineitems?.length.toString() ?? 0} items"),
                  SizedBox(width: 8.h),
                  _customField2("Standard")
                ],
              )),
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
              _customField1(
                  viewModel.orderItemModel.value.lineitems?.length.toString() ??
                      "length"),
            ],
          ),
          //SizedBox(height: 10.v),
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
            // height: MediaQuery.of(ctx).size.height * 0.17,
            // width: MediaQuery.of(ctx).size.width * 1,
            padding: EdgeInsets.all(8.h),
            margin: EdgeInsets.all(6.v),
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
                      //bool showCheckbox = true;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // if (showCheckbox)
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
                                    _status(viewModel.unfulfilledItems[index]
                                            .fulfilmentStatus ??
                                        "status")
                                  ],
                                ),
                                // _customField2(
                                //     viewModel.lineItemList[index].vendor ?? 'N/A'),
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
          SizedBox(height: 10.v),
          Column(
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
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Shipping Fee"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${viewModel.orderItemModel.value.totals?.shipping ?? 0}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Sales Tax"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${viewModel.orderItemModel.value.totals?.tax ?? 0}"),
                ],
              ),
              SizedBox(height: 8.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customField2("Promo Discount"),
                  SizedBox(width: 8.h),
                  _customField2(
                      "Rs. ${viewModel.orderItemModel.value.totals?.discount ?? 0}"),
                ],
              ),
              SizedBox(height: 8.v),
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
          SizedBox(height: 10.v),
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
              color: Colors.grey.shade100,
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
                              // _customField2(
                              //     viewModel.selectedItems[index].vendor ??
                              //         'N/A'),
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

        ///fontWeight: FontWeight.w600,
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
          //style: newFontStyle3,
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
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          barrierDismissible: false,
                        );
                        await viewModel.updateOrder();
                        Get.back();
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
    //clear the checkbox as well
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
