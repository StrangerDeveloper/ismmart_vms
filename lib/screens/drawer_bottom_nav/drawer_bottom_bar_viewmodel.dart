import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/global_variables.dart';
import '../add_product/add_product_1/add_product_1_view.dart';
import '../dashboard/dashboard_view.dart';
import '../order_listing/order_view.dart';
import '../product_list/product_list_view.dart';
import '../setting/settings_view.dart';

class DrawerBottomBarViewModel extends GetxController {
  // List<Widget> bottomNavScreens = [
  //   DashboardView(),
  //   ProductListView(),
  //   AddProduct1View(),
  //   OrderView(),
  //   SettingsView(),
  // ];

  ////////////////////////////////////////////////////////

  Widget selectView(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return ProductListView();
      case 2:
        return AddProduct1View();
      case 3:
        return OrderView();
      case 4:
        return SettingsView();
      default:
        return Container(
          height: 300.0,
          width: Get.width,
          color: Colors.red,
        );
    }
  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (GlobalVariable.selectedIndex.value == 0) {
      final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );

      return value == true;
    } else {
      GlobalVariable.selectedIndex.value = 0;
      return false;
    }
  }
}
