import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_vms/screens/store_profile/store_profile_viewmodel.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_model.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_view.dart';

import '../../helper/global_variables.dart';
import '../add_product/add_product_1/add_product_1_view.dart';
import '../dashboard/dashboard_view.dart';
import '../Order/order_listing/order_view.dart';
import '../product_list/product_list_view.dart';

class DrawerBottomBarViewModel extends GetxController {

   /// for Drawer open and close
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  final box = GetStorage();

  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  @override
  void onInit() {
    box.write('islogin', true);
    userProfileModel = Get.put(StoreProfileViewModel()).userProfileModel;

    super.onInit();
  }

  String appBarTitle(int value) {
    switch (value) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Order List';
      case 2:
        return 'Add Product';
      case 3:
        return 'Products';
      case 4:
        return 'Profile Details';
      default:
        return '';
    }
  }

  Widget selectView(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return OrderView();
      case 2:
        return AddProduct1View();
      case 3:
        return ProductListView();
      case 4:
        return UserProfileView();
      default:
        return Container(
          height: 300.0,
          width: Get.width,
          color: Colors.red,
        );
    }
  }

  onBackPressed(BuildContext context) async {
    if (GlobalVariable.selectedIndex.value == 0) {
      await showDialog(
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
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        exit(0);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else {
      GlobalVariable.selectedIndex.value = 0;
    }
  }
}
