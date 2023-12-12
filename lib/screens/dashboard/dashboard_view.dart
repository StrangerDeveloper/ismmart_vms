import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';

import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/widgets/custom_text.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final DashboardViewModel viewModel = Get.put(DashboardViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: CustomAppBar(
          menuItem: true,
          title: langKey.vendorDashboard.tr,
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _orderStats(),
                  //_divider(),
                  const SizedBox(height: 10),
                  _filters(),
                  _saleChart(),
                  const SizedBox(height: 20),
                  _pieChart(),
                  // _divider(),
                  // _orders(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderStats() {
    return SizedBox(
      height: Get.size.height * 0.1,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          _statsCard(
            title: 'Pending Orders',
            value: 4,
            // onTap: () {},
            // icon: Icons.cases_rounded,
            // iconColor: const Color.fromARGB(255, 159, 107, 251),
          ),
          _statsCard(
            title: 'Approved Orders',
            value: 4,
            // onTap: () {},
            // icon: Icons.cases_rounded,
            // iconColor: const Color.fromARGB(255, 159, 107, 251),
          ),
          _statsCard(
            title: 'Cancelled Orders',
            value: 4,
            // onTap: () {},
            // icon: Icons.cases_rounded,
            // iconColor: const Color.fromARGB(255, 159, 107, 251),
          ),
          _statsCard(
            title: 'Total Sale',
            value: 4939,
            // onTap: () {},
            // icon: Icons.cases_rounded,
            // iconColor: const Color.fromARGB(255, 159, 107, 251),
          ),
          _statsCard(
            title: 'Total Sale',
            value: 4939,
            // onTap: () {},
            // icon: Icons.cases_rounded,
            // iconColor: const Color.fromARGB(255, 159, 107, 251),
          ),
          _statsCard(
            title: 'Total Products',
            value: 60,
            // onTap: () {},
            // icon: Icons.data_array,
            // iconColor: const Color.fromARGB(255, 138, 246, 141),
          ),
          _statsCard(
            title: 'Total Revenu',
            value: 42399,
            // onTap: () {},
            // icon: Icons.data_array,
            // iconColor: const Color.fromARGB(255, 245, 115, 10),
          ),
          _statsCard(
            title: 'Total Customers',
            value: 10,
            // onTap: () {},
            // icon: Icons.data_array,
            // iconColor: const Color.fromARGB(255, 154, 158, 248),
          ),
          _statsCard(
            title: 'Total Traffic',
            value: 7000,
            // onTap: () {},
            // icon: Icons.data_array,
            // iconColor: const Color.fromARGB(255, 245, 115, 10),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    return Container(
      color: kWhiteColor,
      height: Get.size.height * 0.07,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black45,
            ),
            child: const CustomText(
              title: "Filter by Sale",
              color: kWhiteColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black45,
            ),
            child: const CustomText(
              title: "Filter by Date",
              color: kWhiteColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _statsCard({title, value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kLightGreyColor),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: "$value",
              color: kWhiteColor,
              size: 15,
            ),
            CustomText(
              title: "$title",
              color: kWhiteColor,
              size: 13,
            )
          ],
        ),
      ),
    );
  }

  Widget _saleChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: AppConstant.getSize().height / 3,
      child: LineChart(
        LineChartData(
          lineTouchData: viewModel.lineTouchData1,
          gridData: viewModel.gridData,
          titlesData: viewModel.titlesData1,
          borderData: viewModel.borderData,
          lineBarsData: viewModel.lineBarsData1,
          minX: 0,
          maxX: 14,
          maxY: 4,
          minY: 0,
        ),
        duration: const Duration(milliseconds: 350),
      ),
    );
  }

  Widget _pieChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: AppConstant.getSize().height / 3,
      child: Row(
        children: [
          const SizedBox(
            height: 18,
          ),
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
                  sectionsSpace: 5,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),

                swapAnimationDuration:
                    const Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _indicator(
                color: kLightBlueColor,
                text: 'First',
                isSquare: true,
              ),
              const SizedBox(height: 4),
              _indicator(
                color: kGoldColor,
                text: 'Second',
                isSquare: true,
              ),
              const SizedBox(height: 4),
              _indicator(
                color: kPurpleColor,
                text: 'Third',
                isSquare: true,
              ),
              const SizedBox(height: 4),
              _indicator(
                color: kLimeGreenColor,
                text: 'Fourth',
                isSquare: true,
              ),
              const SizedBox(height: 18),
            ],
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _indicator({color, text, bool? isSquare = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: isSquare! ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          title: text,
          size: 12,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == viewModel.pieTouchIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kLightBlueColor,
            value: 40,
            title: '40%',
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
            color: kGoldColor,
            value: 30,
            title: '30%',
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
            value: 15,
            title: '15%',
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
            color: kLimeGreenColor,
            value: 15,
            title: '15%',
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
