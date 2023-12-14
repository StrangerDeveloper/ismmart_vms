import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/setting/settings_viewmodel.dart';
import 'package:ismmart_vms/screens/shippings/shippings_view.dart';

import '../../widgets/custom_button.dart';
import '../bank/bank_profile_view.dart';
import '../store/store_view.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          titleAndBackBtn(),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Store '),
            onTap: () {
              Get.to(StoreView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange_rounded),
            title: const Text(' Banking '),
            onTap: () {
              Get.to(BankProfileView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text(' Shipping '),
            onTap: () {
              //Navigator.pop(context);
              Get.to(() => ShippingMethodsView());
            },
          ),
        ],
      ),
    );
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Align(
            alignment: Alignment.center,
            // child: Text(
            //   'Store Profile',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            // ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
        ],
      ),
    );
  }
}
