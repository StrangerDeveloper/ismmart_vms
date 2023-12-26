import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_listing/model/order_model.dart';
import 'package:ismmart_vms/screens/order_detail/model/ordertracking_item_model.dart';
import 'package:ismmart_vms/screens/order_detail/order_detail_viewModel.dart';
import 'package:ismmart_vms/screens/order_detail/order_tracking/order_tracking_view.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../../helper/global_variables.dart';
import '../../helper/utils/image_constant.dart';
import '../../widgets/appBar_leading_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_loading.dart';
import '../return/return_view.dart';

// ignore: must_be_immutable
class OrderDetailView extends StatelessWidget {
  OrdersDetailPageController controller = Get.put(OrdersDetailPageController());

  final Order order;
  OrderDetailView({Key? key, required this.order}) : super(key: key) {
    //Get.put(OrderViewModel()).fetchOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    //final OrderViewModel orderController = Get.find<OrderViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFrame(),
                        SizedBox(height: 16.v),
                        _buildFrame2(),
                        SizedBox(height: 16.v),
                        logInBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: CustomAppBar(
    //     title: langKey.orderDetail.tr,
    //     backBtn: false,
    //     action: [
    //       IconButton(
    //         onPressed: () {
    //           Get.defaultDialog(
    //             title: 'Delete Order',
    //             middleText: 'Are you sure you want to delete this order?',
    //             textConfirm: 'Yes',
    //             textCancel: 'No',
    //             onConfirm: () {
    //               // Delete order
    //               Get.back();
    //             },
    //           );
    //         },
    //         icon: const Icon(Icons.delete),
    //       ),
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [_buildOrderDetail(order), logInBtn()],
    //       ),
    //     ),
    //   ),
    // );
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
      title: langKey.orderDetail.tr,
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
        CustomTextBtn(
          width: 109.h,
          height: 10.v,
          title: "More actions",
          backgroundColor: Colors.grey.shade200,
          onPressed: () {},
          child: Container(
            margin: EdgeInsets.only(left: 8.h),
            child: Row(
              children: [
                CustomText(
                  title: "More actions",
                  style: TextStyle(
                    fontSize: 10.fSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  size: 16.fSize,
                  color: Colors.black,
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
                  _customField1(order.customerName),
                  _customField1(order.amount.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    _status("Payment pending", "1"),
                    SizedBox(width: 8.h),
                    _status("unfulfilled", "2"),
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
                          //SizedBox(width: 8.h),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     Icons.edit,
                          //     size: 16.fSize,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 8.v),
                      _customField1("Shipping adress"),
                      _customField2("Shehzad Khan"),
                      _customField2(
                          "Dha phase 2 sector C street 8A house 34, \nIslamabad 04403, Pakistan"),
                      _customField2("+92 333 1234567"),
                      SizedBox(height: 8.v),
                      _customField1("Billing adress"),
                      _customField2("Shehzad Khan"),
                      _customField2(
                          "Dha phase 2 sector C street 8A house 34, \nIslamabad 04403, Pakistan"),
                      _customField2("+92 333 1234567"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.v),
        _customField1("Item list"),
        _buildOrderTracking(),
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
        color: Color(0xFF6B7280),

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

  Widget _buildOrderTracking() {
    return Obx(
      () => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.v);
        },
        itemCount: controller
            .ordersDetailPageModelObj.value.ordertrackingItemList.value.length,
        itemBuilder: (context, index) {
          OrdertrackingItemModel model = controller.ordersDetailPageModelObj
              .value.ordertrackingItemList.value[index];
          return OrdertrackingItemWidget(model);
        },
      ),
    );
  }

  // Widget _buildOrderDetail(Order detail) {
  //   List<TableRow> rows = [
  //     _buildTableRow("Order ID", detail.orderId.toString()),
  //     _buildTableRow("Amount", detail.amount.toString()),
  //     _buildTableRow("Customer Name", detail.customerName),
  //     _buildTableRow("Date", detail.date.toString()),
  //     _buildTableRow("Payment Status", detail.paymentStatus),
  //     _buildTableRow("Fulfillment Status", detail.fulfillmentStatus),
  //     _buildTableRow("Delivery Status", detail.deliveryStatus),
  //     // Add other details as needed
  //   ];

  //   // Add a table row for items
  //   rows.add(
  //     TableRow(
  //       children: [
  //         const Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Text("Items", textAlign: TextAlign.start),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             children: _buildItemDetails(detail.items),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   return Table(
  //     border: TableBorder.all(),
  //     columnWidths: const {
  //       0: FlexColumnWidth(1),
  //       1: FlexColumnWidth(2),
  //     },
  //     children: rows,
  //   );
  // }

  // List<Widget> _buildItemDetails(List<Item> items) {
  //   return items.map((item) {
  //     return _buildItemDetail(item);
  //   }).toList();
  // }

  // Widget _buildItemDetail(Item itemDetails) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         CustomText(title: "Item ID: ${itemDetails.itemId}"),
  //         CustomText(title: "Name: ${itemDetails.name}"),
  //         CustomText(title: "Quantity: ${itemDetails.media}"),
  //         CustomText(title: "Price: ${itemDetails.quantity}"),
  //         CustomText(title: "Price: ${itemDetails.price}"),
  //         CustomText(title: "Discounted Price: ${itemDetails.discountedPrice}"),
  //         CustomText(title: "SKU: ${itemDetails.sku}"),
  //         CustomText(title: "Barcode: ${itemDetails.barcode}"),
  //       ],
  //     ),
  //   );
  // }

  // TableRow _buildTableRow(String title, String value) {
  //   return TableRow(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(title, textAlign: TextAlign.start),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Text(value, textAlign: TextAlign.start),
  //       ),
  //     ],
  //   );
  // }

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
