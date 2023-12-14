import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;
import 'package:ismmart_vms/screens/setting/settings_viewmodel.dart';
import 'package:ismmart_vms/screens/shippings/shippings_view.dart';

import '../store/store_view.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Hasnain Mirrani",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text("hmirrani@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Store '),
            onTap: () {
              Get.to(StoreView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Banking '),
            onTap: () {
              Navigator.pop(context);
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
}
