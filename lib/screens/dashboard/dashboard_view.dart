import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/image_constant.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/custom_dropdown.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/resourses/app_colors.dart';
import '../../widgets/custom_drawer.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: const CustomDrawer(),
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                welcomeWidget(),
                const Divider(color: Color(0xFFE5E7EB)),
                todayAndProgressReport(),
                ordersProgress(),
                SizedBox(height: 24.v),
                _buildCharts(),
              ],
            ),
          ),
          const LoaderView()
        ],
      ),
    );
  }

  CustomAppBar2 appBar() {
    return CustomAppBar2(
      leading: Container(),
      title: 'Al - Jannat Mall',
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        )
      ],
    );
  }

  Widget welcomeWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Al-jannat Mall",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 5),
          Icon(
            CupertinoIcons.info_circle_fill,
            color: Color(0xff9CA3AF),
            size: 12,
          )
        ],
      ),
    );
  }

  Widget todayAndProgressReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: CustomDropDownList2(
            value: viewModel.dateSelected,
            onChanged: (value) {
              viewModel.dateSelected.value = value;
            },
            list: viewModel.dateDropDownList,
          ),
        ),
        CustomTextBtn(
          foregroundColor: ThemeHelper.blue1,
          backgroundColor: Colors.transparent,
          width: double.minPositive,
          child: const Row(
            children: [
              Text(
                'Progress report',
                style: TextStyle(
                  color: ThemeHelper.blue1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.chevron_right_rounded)
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget ordersProgress() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Orders",
                style: TextStyle(
                  color: ThemeHelper.grey5,
                  fontSize: 12,
                ),
              ),
              Text(
                "77",
                style: TextStyle(
                  color: ThemeHelper.grey5,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              orderStatusItem(
                title: "Exception",
                value: "5",
                color: deepOrangeA700,
              ),
              const SizedBox(width: 10),
              orderStatusItem(
                title: "New Orders",
                value: "3",
                color: cyan800,
              ),
              const SizedBox(width: 10),
              orderStatusItem(
                title: "In Progress",
                value: "18",
                color: blueA700,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextBtn(
              padding: const EdgeInsets.only(right: 20),
              width: double.minPositive,
              foregroundColor: ThemeHelper.grey5,
              backgroundColor: Colors.transparent,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Show more details",
                    style: TextStyle(
                      color: ThemeHelper.grey5,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 10,
                    color: ThemeHelper.grey5,
                  )
                ],
              ),
              onPressed: () {
                viewModel.showMoreDetails.value =
                    !viewModel.showMoreDetails.value;
              },
            ),
          ),
          showMoreDetails(),
        ],
      ),
    );
  }

  Widget orderStatusItem({
    String? title,
    String? value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: Text(
                "$value",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              "$title",
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showMoreDetails() {
    return Obx(() => viewModel.showMoreDetails.value
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Color(0xFFE5E7EB),
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 6),
                child: Column(
                  children: [
                    _buildShowMoreItems(
                      title: "Total Sales",
                      value: "",
                      customValue: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xff03543F).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              color: Color(0xff03543F),
                              size: 14,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '78 %',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: _buildShowMoreItems(
                        title: "Total Products",
                        value: "20",
                      ),
                    ),
                    _buildShowMoreItems(
                      title: "Total Revenue",
                      value: "500,000 PKR",
                    ),
                  ],
                ),
              )
            ],
          )
        : const SizedBox());
  }

  Widget _buildShowMoreItems({
    required String title,
    required String value,
    Widget? customValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ThemeHelper.grey5,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        customValue ??
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ),
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
          SizedBox(height: 300.v, width: 264.h, child: _pieChart()),
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
            aspectRatio: 1.3,
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
                  show: false,
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 1,
                sections: showingSections(),
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.bounceIn,
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
              color: cyan,
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
      final fontSize = isTouched ? 15.0 : 13.0;
      final radius = isTouched ? 110.0 : 120.0;
      // const shadows = [
      //   Shadow(color: Color.fromARGB(255, 5, 5, 5), blurRadius: 2)
      // ];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: cyan,
            value: 15,
            title: '15%\nAffiliate',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
              //shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: amber400,
            value: 15,
            title: '15%\nSearch',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
              //shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: kPurpleColor,
            value: 30,
            title: ' 30%\nCollection',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
              //shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: blueA700,
            value: 40,
            title: ' 40%\nDireact',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: kWhiteColor,
              //shadows: shadows,
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
