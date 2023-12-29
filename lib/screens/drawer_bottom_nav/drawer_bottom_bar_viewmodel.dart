import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/location_list/location_list_view.dart';
import 'package:ismmart_vms/screens/order_listing/order_view.dart';
import 'package:ismmart_vms/screens/product_list/product_list_view.dart';
import 'package:ismmart_vms/screens/setting/settings_view.dart';

import '../dashboard/dashboard_view.dart';

class DrawerBottomBarViewModel extends GetxController {
  PageController bottomNavPageController = PageController(initialPage: 0);
  RxInt currentPageIndex = 0.obs;

  List<Widget> bottomNavScreens = [
    DashboardView(),
    ProductListView(),
    AddProduct1View(),
    OrderView(),
    SettingsView(),
  ];
  void changePage(int index) {
    currentPageIndex.value = index;
    bottomNavPageController.jumpToPage(index);
  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (currentPageIndex.value == 0) {
      final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(exitApp.tr),
            content: Text(exitDialogDesc.tr),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        foregroundColor: Colors.grey,
                      ),
                      child: Text(
                        noBtn.tr,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        foregroundColor: Colors.grey,
                      ),
                      child: Text(
                        yesBtn.tr,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
      currentPageIndex(0);
      return false;
    }
  }
}
