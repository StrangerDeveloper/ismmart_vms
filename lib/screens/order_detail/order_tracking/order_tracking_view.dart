import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/order_detail/order_detail_ciewModel.dart';

import '../model/ordertracking_item_model.dart';

// ignore: must_be_immutable
class OrdertrackingItemWidget extends StatelessWidget {
  OrdertrackingItemWidget(
    this.ordertrackingItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  OrdertrackingItemModel ordertrackingItemModelObj;

  var controller = Get.find<OrdersDetailPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      //color: Colors.grey[200],
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: Colors.grey[200],
      ),
      // decoration: AppDecoration.outlineBlack.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder10,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  ordertrackingItemModelObj.orderTrackingId!.value,
                  //style: CustomTextStyles.labelLargeGray600,
                ),
              ),
              Obx(
                () => Text(
                  ordertrackingItemModelObj.orderTrackingIdNumber!.value,
                  // style: CustomTextStyles.labelLargePrimary.copyWith(
                  //   decoration: TextDecoration.underline,
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                top: 2.v,
                right: 4.h,
              ),
              child: Obx(
                () => _status(ordertrackingItemModelObj.pending!.value, "1"),
                // () => Text(
                //   ordertrackingItemModelObj.pending!.value,
                //   // style: CustomTextStyles.bodySmallGray900,
                // ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomImageView(
              //   imagePath: ImageConstant.imgDummyProduct,
              //   height: 30.adaptSize,
              //   width: 5.adaptSize,
              //   radius: BorderRadius.circular(
              //     5.h,
              //   ),
              //   margin: EdgeInsets.only(bottom: 12.v),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  top: 2.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.axelArigato!.value,
                        //style: CustomTextStyles.labelLargePrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.iSMMARTOriginals!.value,
                        //style: CustomTextStyles.bodySmallDMSansGray900,
                      ),
                    ),
                    SizedBox(height: 1.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.sKUACamera!.value,
                        //style: CustomTextStyles.bodySmallDMSans,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.v,
                  bottom: 35.v,
                ),
                child: Obx(
                  () => Text(
                    ordertrackingItemModelObj.rsCounter!.value,
                    //style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 56.h),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.v),
                    child: Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter1!.value,
                        //style: CustomTextStyles.labelLargeOnPrimaryContainer,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Obx(
                      () => Text(
                        ordertrackingItemModelObj.xCounter!.value,
                        //style: CustomTextStyles.labelLargeOnPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 38.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgDummyProduct,
                        //   height: 40.adaptSize,
                        //   width: 40.adaptSize,
                        //   radius: BorderRadius.circular(
                        //     10.h,
                        //   ),
                        //   margin: EdgeInsets.only(bottom: 12.v),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  ordertrackingItemModelObj.nikeCounter!.value,
                                  // style: CustomTextStyles
                                  //     .labelLargePrimaryContainer,
                                ),
                              ),
                              SizedBox(height: 6.v),
                              Obx(
                                () => Text(
                                  ordertrackingItemModelObj
                                      .iSMMARTOriginals1!.value,
                                  // style:
                                  //     CustomTextStyles.bodySmallDMSansGray900,
                                ),
                              ),
                              SizedBox(height: 1.v),
                              Obx(
                                () => Text(
                                  ordertrackingItemModelObj.sKUACamera1!.value,
                                  //style: CustomTextStyles.bodySmallDMSans,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 56.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.v),
                              child: Obx(
                                () => Text(
                                  ordertrackingItemModelObj.rsCounter2!.value,
                                  //style: CustomTextStyles.labelLargeOnPrimaryContainer,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.h),
                              child: Obx(
                                () => Text(
                                  ordertrackingItemModelObj.xCounter!.value,
                                  //style: CustomTextStyles.labelLargeOnPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Row(
                      children: [
                        Obx(
                          () => Text(
                            ordertrackingItemModelObj.subTotal!.value,
                            //style: CustomTextStyles.labelMediumGray900,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Obx(
                            () => Text(
                              ordertrackingItemModelObj.itemsCounter!.value,
                              //style: theme.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            ordertrackingItemModelObj.shippingFee!.value,
                            //style: CustomTextStyles.labelMediumGray900,
                          ),
                        ),
                        Obx(
                          () => Text(
                            ordertrackingItemModelObj.standardKg!.value,
                            //style: theme.textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.promoDiscount!.value,
                        //style: CustomTextStyles.labelMediumGray900,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.totalAmount!.value,
                        //style: CustomTextStyles.labelMediumGray900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter3!.value,
                        //style: theme.textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: 99.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter4!.value,
                        //style: theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter5!.value,
                        //style: theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter6!.value,
                        //style: theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Obx(
                      () => Text(
                        ordertrackingItemModelObj.rsCounter7!.value,
                        //style: theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    // CustomTextBtn(
                    //   onPressed: () {},
                    //   title: "Fulfill Item",
                    // )
                  ],
                ),
              ),
            ],
          ),
        ],
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
}
