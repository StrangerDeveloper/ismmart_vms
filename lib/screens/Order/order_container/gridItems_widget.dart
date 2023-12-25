import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';

import '../model/gridItem_model.dart';
import 'ordersPage_viewModel.dart';

// ignore: must_be_immutable
class GriditemsItemWidget extends StatelessWidget {
  GriditemsItemWidget(
    this.griditemsItemModelObj, {
    super.key,
    this.onTapItem,
  });

  GriditemsItemModel griditemsItemModelObj;

  var controller = Get.find<OrdersController>();

  VoidCallback? onTapItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem!.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.h,
          vertical: 5.v,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F1),
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //width: 22.adaptSize,
              padding: EdgeInsets.symmetric(
                horizontal: 12.h,
                vertical: 2.v,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFEECDC),
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Obx(
                () => Text(
                  griditemsItemModelObj.iconShapesText!.value,
                  //style: CustomTextStyles.titleSmallDeeporangeA700,
                ),
              ),
            ),
            SizedBox(height: 9.v),
            Obx(
              () => Text(
                griditemsItemModelObj.newOrdersText!.value,
                //style: CustomTextStyles.labelLargeDeeporangeA700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
