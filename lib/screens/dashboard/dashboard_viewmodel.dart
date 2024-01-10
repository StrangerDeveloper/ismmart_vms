import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/store_profile/store_profile_viewmodel.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_model.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

import '../../helper/global_variables.dart';

class DashboardViewModel extends GetxController {
  RxBool showMoreDetails = false.obs;
  RxString dateSelected = '1'.obs;
  List<DropDownModel> dateDropDownList = <DropDownModel>[
    DropDownModel(id: "1", name: "Today"),
    DropDownModel(id: "2", name: "25 Dec 2023"),
    DropDownModel(id: "3", name: "24 Dec 2023"),
    DropDownModel(id: "4", name: "23 Dec 2023"),
  ].obs;

  RxBool isTab = false.obs;
  RxBool moreOption = false.obs;
  RxBool orderMoreOption = false.obs;

  var pieTouchIndex = -1.obs;
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

  RxString rejected = ''.obs;

  Rx<DateTime> pickedDate = DateTime.now().obs;

  @override
  void onReady() {
    rejected.value = Get.arguments ?? '';
    super.onReady();

    getOrdersData();

    userProfileModel = Get.put(StoreProfileViewModel()).userProfileModel;
  }

  // onDateChanged(String value) {
  //   if()
  // }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  String getDateFormat() {
    if (pickedDate.value.compareTo(DateTime.now()) > 1) {
      return "Today";
    }
    return CommonFunction.formattedDataTime("dd MMMM yyyy", pickedDate.value);
  }

  showCustomDatePicker() async {
    pickedDate.value = (await showDatePicker(
      context: Get.context!,
      initialDate: pickedDate.value,
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    ))!;
  }

  void getOrdersData() {}

  ///*************Chart Data */ ///
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: kLightBlueColor.withOpacity(0.8),
        ),
      );
  FlGridData get gridData => const FlGridData(show: false);
  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: kPrimaryColor.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: kRedColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: kPurpleColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: kPurpleColor.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: kGoldColor,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  Future<void> logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    await googleSignIn.signOut();

    Get.offAll(() => LogInView());
  }
}
