import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/Order/order_container/gridItems_widget.dart';
import 'package:ismmart_vms/screens/Order/order_container/ordersPage_viewModel.dart';

import '../../../helper/utils/size_utils.dart';
import '../../order_listing/order_view.dart';
import '../model/gridItem_model.dart';
import '../../order_listing/model/order_model.dart';

// ignore: must_be_immutable
class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  OrdersController controller = Get.put(OrdersController(OrdersModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.h),
              topRight: Radius.circular(24.h),
            ),
          ),
          child: Column(
            children: [SizedBox(height: 5.v), _buildGridItems()],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGridItems() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 101.v,
              crossAxisCount: 3,
              mainAxisSpacing: 13.h,
              crossAxisSpacing: 13.h),
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              controller.ordersModelObj.value.griditemsItemList.value.length,
          itemBuilder: (context, index) {
            GriditemsItemModel model =
                controller.ordersModelObj.value.griditemsItemList.value[index];
            return GriditemsItemWidget(
              model,
              onTapItem: () {
                Get.to(() => OrderView());
              },
            );
          },
        ),
      ),
    );
  }
}
