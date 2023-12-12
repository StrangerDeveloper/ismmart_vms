import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ismmart_vms/screens/dashboard/model/order_model.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';

import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../../widgets/no_data_found.dart';

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
                  _stats(),
                  const SizedBox(height: 10),
                  _saleChart(),
                  const SizedBox(
                    height: 20,
                  ),
                  _divider(),
                  _orders(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stats() {
    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          _statsCard(title: 'Total Sale', value: 4939),
          _statsCard(title: 'Total Products', value: 60),
          _statsCard(title: 'Total Customers', value: 10),
          _statsCard(title: 'Total Revenu', value: 42399),
        ],
      ),
    );
  }

  Widget _statsCard({title, value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
            color: Colors.black45, shape: BoxShape.rectangle),
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

  Widget _divider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            langKey.orderSummary.tr,
            //style: newFontStyle4,
          ),
        ),
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _orders() {
    return Obx(() => listView(list: viewModel.orderList));

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
  }

  TabBar tabBar() {
    return TabBar(
      labelStyle: headline4,
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 15),
      labelColor: kPrimaryColor,
      indicatorColor: kPrimaryColor,
      tabs: [
        Tab(text: langKey.pending.tr),
        Tab(text: langKey.accepted.tr),
        //Tab(text: langKey.shipped.tr),
        //Tab(text: langKey.delivered.tr),
        Tab(text: langKey.cancelled.tr),
      ],
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        children: [
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
        ],
      ),
    );
  }

  Widget listView({required List<OrderModel> list}) {
    return list.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _orderListItem(
                orderModel: list[index],
              );
            },
          )
        : NoDataFound(text: langKey.noOrderFound.tr);
  }

  Widget _orderListItem({OrderModel? orderModel}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(1, 1),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    title: '${langKey.order.tr} #${orderModel!.id}',
                    style: headline3,
                  ),
                  const SizedBox(width: 10),
                  if (orderModel.status != null)
                    CustomText(
                      title: orderModel.status?.capitalizeFirst ?? "",
                      weight: FontWeight.w600,
                      color: AppConstant.getStatusColor(orderModel),
                    ),
                ],
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Total Price:  ",
                      style: TextStyle(color: kPrimaryColor)),
                  TextSpan(
                      text: "${orderModel.totalPrice}",
                      style: const TextStyle(color: kPrimaryColor)),
                ]),
              ),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Total Shipping:  ",
                      style: TextStyle(color: kPrimaryColor)),
                  TextSpan(
                      text: "${orderModel.shippingPrice}",
                      style: const TextStyle(color: kPrimaryColor)),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
