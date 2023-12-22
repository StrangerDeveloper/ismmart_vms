import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/Order/order_tabContainer/orders_tab_viewModel.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../../helper/utils/image_constant.dart';
import '../../../widgets/appBar_leading_image.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_textfield.dart';
import '../order_tabContainer/orders_tab_model.dart';

class OrderContainerView extends StatelessWidget {
  OrderContainerView({super.key});

  OrdersTabContainerController controller =
      Get.put(OrdersTabContainerController(OrdersTabContainerModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              _buildCreateCollection(),
              SizedBox(height: 18.v),
              _buildSearch(),
              SizedBox(height: 16.v),
              _buildTabview(),
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
      title: "Order List",
    );
  }

  Widget _buildCreateCollection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomRoundedTextBtn(
            title: "Create Order",
            height: 48.v,
            width: 148.v,
            backgroundColor: Color(0xFF3669C9),
            onPressed: () {},
            child: const Text("Create Order"),
          ),
          CustomIconButton(
            height: 36.adaptSize,
            width: 36.adaptSize,
            padding: EdgeInsets.all(10.h),
            child: CustomImageView(imagePath: ImageConstant.imgDownload),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField1(
            title: 'Orders Location:',
            filled: false,
            hintText: 'All Locations',
            readOnly: true,
            isDropDown: true,
            onTap: () {
              // Get.to(() => AddOrderView());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabview() {
    return Container(
      height: 38.v,
      width: 327.h,
      decoration: BoxDecoration(
        //color: Colors.grey,
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: TabBar(
        controller: controller.tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: Colors.white,
        labelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500),
        unselectedLabelColor: Colors.black,
        unselectedLabelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500),
        indicatorSize: TabBarIndicatorSize.tab,
        //indicatorPadding: EdgeInsets.symmetric(horizontal: 8.h),
        indicator: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.h),
        ),
        tabs: [
          Tab(child: Text("lbl_today".tr)),
          Tab(child: Text("lbl_7_days".tr)),
          Tab(child: Text("lbl_30_days".tr))
        ],
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }
}
