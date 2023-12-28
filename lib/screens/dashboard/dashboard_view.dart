import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/utils/image_constant.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_dropdown.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';

import '../../helper/resourses/app_colors.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final DashboardViewModel viewModel = Get.put(DashboardViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: const CustomDrawer(),
        appBar: _buildAppBar(),
        body: _body(),

        // CustomAppBar(
        //   menuItem: true,
        //   title: langKey.vendorDashboard.tr,
        // ),
        // body: CustomScrollView(
        //   slivers: [
        //     SliverList(
        //       delegate: SliverChildListDelegate(
        //         [
        //           _orderStats(),
        //           //_divider(),
        //           const SizedBox(height: 10),
        //           _filters(),
        //           _saleChart(),
        //           const SizedBox(height: 20),
        //           _pieChart(),
        //           // _divider(),
        //           // _orders(),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  _buildAppBar() {
    return CustomAppBar1(
      leadingWidth: 48.h,
      leading: Container(
        margin: EdgeInsets.only(
          left: 24.h,
          top: 10.v,
          bottom: 10.v,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 3.h,
          vertical: 6.v,
        ),
        // decoration: AppDecoration.fillWhiteA,
        child: Padding(
          padding: EdgeInsets.zero,
          child: CustomImageView(
            imagePath: ImageConstant.imgMegaphone,
            height: 24.adaptSize,
            width: 24.adaptSize,
            fit: BoxFit.contain,
          ),
        ),

        // AppbarImage(
        //   imagePath: ImageConstant.imgMegaphone,
        // ),
      ),
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text("Al - Jannat Mall",
            style: TextStyle(fontSize: 12.fSize, color: gray60001)),
      ),

      // AppbarSubtitle(
      //   text: "lbl_ismmart".tr,
      // ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 10.v,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgBell,
            height: 24.adaptSize,
            width: 24.adaptSize,
            fit: BoxFit.contain,
          ),
        ),
      ],
      styleType: Style.bgShadow,
    );
  }

  Widget _body() {
    return Column(
      children: [
        SizedBox(height: 14.v),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 7.h),
              padding: EdgeInsets.symmetric(
                horizontal: 24.h,
                vertical: 16.v,
              ),
              // decoration: AppDecoration.shadow.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder10,
              // ),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Welcome Al-jannat Mall",
                          style: TextStyle(
                              fontSize: 16.fSize,
                              fontWeight: FontWeight.w700,
                              color: gray900),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgInfo,
                          height: 12.adaptSize,
                          width: 12.adaptSize,
                          margin: EdgeInsets.only(
                            left: 6.h,
                            top: 2.v,
                            bottom: 2.v,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.v),
                  _buildHeading(),
                  SizedBox(height: 12.v),
                  _buildCard(),
                  SizedBox(height: 24.v),
                  _buildCharts(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.v),
      // decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.v),
            child: SizedBox(
              width: 107.h,
              child: CustomDropDownList1(
                value: viewModel.dateSelected,
                onChanged: (value) {
                  viewModel.dateSelected.value = value;
                },
                dropdownList: viewModel.dateDropDownList,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 16.v),
            child: Text(
              "Progress Report",
              style: TextStyle(
                  fontSize: 14.fSize,
                  color: blue20001,
                  fontWeight: FontWeight.w600),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowUp,
            height: 10.adaptSize,
            width: 10.adaptSize,
            margin: EdgeInsets.only(
              left: 6.h,
              top: 19.v,
              bottom: 3.v,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      padding: EdgeInsets.all(12.h),
      // decoration: AppDecoration.fillGray5001.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder10,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Orders", style: TextStyle(color: gray60001)),
              const Spacer(),
              Text("77".tr,
                  style: TextStyle(fontSize: 13.fSize, color: gray60001)),
            ],
          ),
          SizedBox(height: 13.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCardItem(
                title: "Exception",
                value: "5",
                color: deepOrangeA700,
                // decoration: AppDecoration.fillOrange.copyWith(
                //   borderRadius: BorderRadiusStyle.circleBorder16,
                // ),
              ),
              _buildCardItem(
                title: "New Orders",
                value: "3",
                color: cyan800,
                // decoration: AppDecoration.fillCyan.copyWith(
                //   borderRadius: BorderRadiusStyle.circleBorder16,
                // ),
              ),
              _buildCardItem(
                title: "In Progress",
                value: "18",
                color: blueA700,
                // decoration: AppDecoration.fillBlue.copyWith(
                //   borderRadius: BorderRadiusStyle.circleBorder16,
                // ),
              ),
            ],
          ),
          SizedBox(height: 13.v),
          _buildShowMoreDetails(),
        ],
      ),
    );
  }

  Widget _buildCardItem({String? title, String? value, color, decoration}) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 13.h,
            vertical: 12.v,
          ),
          // decoration: AppDecoration.fillGray10003.copyWith(
          //   borderRadius: BorderRadiusStyle.roundedBorder10,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.adaptSize,
                padding: EdgeInsets.symmetric(
                  horizontal: 11.h,
                  vertical: 7.v,
                ),
                decoration: decoration,
                child: Text(
                  "$value",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.fSize,
                    color: color,
                  ),
                ),
              ),
              SizedBox(height: 9.v),
              Text(
                "$title",
                style: TextStyle(color: color, fontSize: 14.fSize, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowMoreDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Show more details",
              style: TextStyle(fontSize: 12.fSize, color: gray60001),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgArrowUp,
              height: 8.adaptSize,
              width: 8.adaptSize,
              margin: EdgeInsets.only(
                left: 6.h,
                top: 3.v,
                bottom: 3.v,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 13.v,
        ),
        Column(
          children: [
            SizedBox(height: 12.v),
            _buildShowMoreItems(
                title: "Total Sale",
                value: "78%",
                color: cyan50,
                // decoration: AppDecoration.fillCyan.copyWith(
                //     borderRadius: BorderRadiusStyle.roundedBorder10,
                //     color: cyan50),
                hasSuffixIcon: true),
            SizedBox(height: 15.v),
            _buildShowMoreItems(
              title: "Total Products",
              value: "20",
              color: gray10001,
              // decoration: AppDecoration.fillGray10001.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder10,
              // ),
            ),
            SizedBox(height: 15.v),
            _buildShowMoreItems(
              title: "Total Revenue",
              value: "500,000 PKR",
              color: gray100,
              // decoration: AppDecoration.fillGray10001.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder10,
              // ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildShowMoreItems(
      {String? title,
      String? value,
      color,
      decoration,
      bool? hasSuffixIcon = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.v),
          child: Text(
            title!,
            style: TextStyle(
                color: gray60001,
                fontWeight: FontWeight.w600,
                fontSize: 13.fSize),
          ),
        ),
        Container(
          height: 22.v,
          width: 66.h,
          decoration: decoration,
          child: !hasSuffixIcon!
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13.fSize,
                        fontWeight: FontWeight.w500,
                        color: gray60001),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward_outlined,
                      size: 14.adaptSize,
                      weight: 2,
                    ),
                    SizedBox(width: 5.v),
                    Text(
                      value!,
                      style: TextStyle(
                          fontSize: 13.fSize,
                          fontWeight: FontWeight.w600,
                          color: gray60001),
                    )
                  ],
                ),
        )
      ],
    );
  }

  Widget _buildCharts() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 25.v,
      ),
      // decoration: AppDecoration.shadow.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder10,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Traffic",
                style: TextStyle(
                    color: gray60001,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.fSize),
              ),

              CustomImageView(
                imagePath: ImageConstant.imgInfo,
                height: 12.adaptSize,
                width: 12.adaptSize,
                margin: EdgeInsets.only(
                  left: 6.h,
                  bottom: 4.v,
                ),
              ),
              const Spacer(),
              // Icon(
              //   Icons.download_rounded,
              //   size: 12.adaptSize,
              // ),
              CustomImageView(
                imagePath: ImageConstant.imgDownload,
                height: 16.adaptSize,
                width: 16.adaptSize,
                margin: EdgeInsets.only(bottom: 2.v),
              ),
            ],
          ),
          SizedBox(height: 24.v),
          SizedBox(
              height: 300.v,
              width: 264.h,
              child: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //       left: 80.h,
                  //       top: 120.v,
                  //       right: 80.h,
                  //     ),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           "500,000",
                  //           style: TextStyle(
                  //               color: gray60001,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 20.fSize),
                  //         ),
                  //         SizedBox(height: 6.v),
                  //         Text(
                  //           "PKR",
                  //           style: TextStyle(
                  //               color: gray60001,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 18.fSize),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  _pieChart(),
                ],
              )),
        ],
      ),
    );
  }

  // Widget _orderStats() {
  //   return SizedBox(
  //     height: Get.size.height * 0.1,
  //     child: ListView(
  //       shrinkWrap: true,
  //       physics: const BouncingScrollPhysics(),
  //       scrollDirection: Axis.horizontal,
  //       children: [
  //         _statsCard(
  //           title: 'Pending Orders',
  //           value: 4,
  //           // onTap: () {},
  //           // icon: Icons.cases_rounded,
  //           // iconColor: const Color.fromARGB(255, 159, 107, 251),
  //         ),
  //         _statsCard(
  //           title: 'Approved Orders',
  //           value: 4,
  //           // onTap: () {},
  //           // icon: Icons.cases_rounded,
  //           // iconColor: const Color.fromARGB(255, 159, 107, 251),
  //         ),
  //         _statsCard(
  //           title: 'Cancelled Orders',
  //           value: 4,
  //           // onTap: () {},
  //           // icon: Icons.cases_rounded,
  //           // iconColor: const Color.fromARGB(255, 159, 107, 251),
  //         ),
  //         _statsCard(
  //           title: 'Total Sale',
  //           value: 4939,
  //           // onTap: () {},
  //           // icon: Icons.cases_rounded,
  //           // iconColor: const Color.fromARGB(255, 159, 107, 251),
  //         ),
  //         _statsCard(
  //           title: 'Total Sale',
  //           value: 4939,
  //           // onTap: () {},
  //           // icon: Icons.cases_rounded,
  //           // iconColor: const Color.fromARGB(255, 159, 107, 251),
  //         ),
  //         _statsCard(
  //           title: 'Total Products',
  //           value: 60,
  //           // onTap: () {},
  //           // icon: Icons.data_array,
  //           // iconColor: const Color.fromARGB(255, 138, 246, 141),
  //         ),
  //         _statsCard(
  //           title: 'Total Revenu',
  //           value: 42399,
  //           // onTap: () {},
  //           // icon: Icons.data_array,
  //           // iconColor: const Color.fromARGB(255, 245, 115, 10),
  //         ),
  //         _statsCard(
  //           title: 'Total Customers',
  //           value: 10,
  //           // onTap: () {},
  //           // icon: Icons.data_array,
  //           // iconColor: const Color.fromARGB(255, 154, 158, 248),
  //         ),
  //         _statsCard(
  //           title: 'Total Traffic',
  //           value: 7000,
  //           // onTap: () {},
  //           // icon: Icons.data_array,
  //           // iconColor: const Color.fromARGB(255, 245, 115, 10),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _filters() {
  //   return Container(
  //     color: kWhiteColor,
  //     height: Get.size.height * 0.07,
  //     width: double.infinity,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(10),
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: Colors.black45,
  //           ),
  //           child: const CustomText(
  //             title: "Filter by Sale",
  //             color: kWhiteColor,
  //           ),
  //         ),
  //         Container(
  //           padding: const EdgeInsets.all(10),
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: Colors.black45,
  //           ),
  //           child: const CustomText(
  //             title: "Filter by Date",
  //             color: kWhiteColor,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _statsCard({title, value}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       width: 140,
  //       padding: const EdgeInsets.symmetric(horizontal: 5),
  //       decoration: BoxDecoration(
  //         color: kWhiteColor,
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: kLightGreyColor),
  //         boxShadow: [
  //           BoxShadow(
  //             color: kPrimaryColor.withOpacity(0.2),
  //             offset: const Offset(0, 1),
  //             blurRadius: 8,
  //           )
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           CustomText(
  //             title: "$value",
  //             color: kWhiteColor,
  //             size: 15,
  //           ),
  //           CustomText(
  //             title: "$title",
  //             color: kWhiteColor,
  //             size: 13,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _saleChart() {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     width: double.infinity,
  //     height: AppConstant.getSize().height / 3,
  //     child: LineChart(
  //       LineChartData(
  //         lineTouchData: viewModel.lineTouchData1,
  //         gridData: viewModel.gridData,
  //         titlesData: viewModel.titlesData1,
  //         borderData: viewModel.borderData,
  //         lineBarsData: viewModel.lineBarsData1,
  //         minX: 0,
  //         maxX: 14,
  //         maxY: 4,
  //         minY: 0,
  //       ),
  //       duration: const Duration(milliseconds: 350),
  //     ),
  //   );
  // }

  Widget _pieChart() {
    return Column(
      children: [
        SizedBox(height: 18.v),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      viewModel.pieTouchIndex = -1;
                      return;
                    }
                    viewModel.pieTouchIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                ),
                sectionsSpace: 10,
                centerSpaceRadius: 90,
                sections: showingSections(),
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear,
            ),
          ),
        ),
        SizedBox(height: 24.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _indicator(
              color: blueA700,
              text: 'Direct',
              isSquare: true,
            ),
            const SizedBox(width: 4),
            _indicator(
              color: cyan800,
              text: 'Affiliate',
              isSquare: true,
            ),
            const SizedBox(width: 4),
            _indicator(
              color: amber400,
              text: 'Collections ',
              isSquare: true,
            ),
            const SizedBox(width: 4),
            _indicator(
              color: kPurpleColor,
              text: 'Search',
              isSquare: true,
            ),
            //const SizedBox(height: 18),
          ],
        ),
        // const SizedBox(width: 28),
      ],
    );
  }

  Widget _indicator({color, text, bool? isSquare = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4.v),
        Text(
          text,
          style: TextStyle(
            fontSize: 10.fSize,
          ),
        ),

        // CustomText(
        //   title: text,
        //   size: 10,
        // ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == viewModel.pieTouchIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 25.0 : 15.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: cyan800,
            value: 15,
            title: 'Affiliate 15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: amber400,
            value: 15,
            title: 'Search 15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: kPurpleColor,
            value: 30,
            title: 'Collection 30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: blueA700,
            value: 40,
            title: 'Direact 40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  // Widget _divider() {
  //   return Row(
  //     children: [
  //       const Expanded(
  //         child: Divider(
  //           //color: newColorLightGrey,
  //           thickness: 1,
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(
  //           langKey.orderSummary.tr,
  //           //style: newFontStyle4,
  //         ),
  //       ),
  //       const Expanded(
  //         child: Divider(
  //           //color: newColorLightGrey,
  //           thickness: 1,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _orders() {
  //   return Obx(() => listView(list: viewModel.orderList));

  // return DefaultTabController(
  //   length: 3,
  //   child: Scaffold(
  //     backgroundColor: kRedColor,
  //     body: Column(
  //       children: [
  //         tabBar(),
  //         //tabBarView(),
  //       ],
  //     ),
  //   ),
  // );
  // }

  // TabBar tabBar() {
  //   return TabBar(
  //     labelStyle: headline4,
  //     isScrollable: true,
  //     labelPadding: const EdgeInsets.symmetric(horizontal: 15),
  //     labelColor: kPrimaryColor,
  //     indicatorColor: kPrimaryColor,
  //     tabs: [
  //       Tab(text: langKey.pending.tr),
  //       Tab(text: langKey.accepted.tr),
  //       //Tab(text: langKey.shipped.tr),
  //       //Tab(text: langKey.delivered.tr),
  //       Tab(text: langKey.cancelled.tr),
  //     ],
  //   );
  // }

  // Widget tabBarView() {
  //   return const Expanded(
  //     child: TabBarView(
  //       children: [
  // Obx(
  //   () => listView(
  //     list: viewModel.pendingOrderList,
  //   ),
  // ),
  // Obx(
  //   () => listView(
  //     list: viewModel.approvedOrderList,
  //   ),
  // ),
  // Obx(
  //   () => listView(
  //     list: viewModel.cancelledOrderList,
  //   ),
  // ),
  //     ],
  //   ),
  // );
  // }

  // Widget listView({required List<OrderModel> list}) {
  //   return list.isNotEmpty
  //       ? ListView.builder(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: list.length,
  //           itemBuilder: (context, index) {
  //             return _orderListItem(
  //               orderModel: list[index],
  //             );
  //           },
  //         )
  //       : NoDataFound(text: langKey.noOrderFound.tr);
  // }

  // Widget _orderListItem({OrderModel? orderModel}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(6),
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.shade300,
  //             offset: const Offset(1, 1),
  //             blurRadius: 5,
  //             spreadRadius: 2,
  //           )
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 CustomText(
  //                   title: '${langKey.order.tr} #${orderModel!.id}',
  //                   style: headline3,
  //                 ),
  //                 const SizedBox(width: 10),
  //                 if (orderModel.status != null)
  //                   CustomText(
  //                     title: orderModel.status?.capitalizeFirst ?? "",
  //                     weight: FontWeight.w600,
  //                     color: AppConstant.getStatusColor(orderModel),
  //                   ),
  //               ],
  //             ),
  //             RichText(
  //               text: TextSpan(children: [
  //                 const TextSpan(
  //                     text: "Total Price:  ",
  //                     style: TextStyle(color: kPrimaryColor)),
  //                 TextSpan(
  //                     text: "${orderModel.totalPrice}",
  //                     style: const TextStyle(color: kPrimaryColor)),
  //               ]),
  //             ),
  //             RichText(
  //               text: TextSpan(children: [
  //                 const TextSpan(
  //                     text: "Total Shipping:  ",
  //                     style: TextStyle(color: kPrimaryColor)),
  //                 TextSpan(
  //                     text: "${orderModel.shippingPrice}",
  //                     style: const TextStyle(color: kPrimaryColor)),
  //               ]),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
