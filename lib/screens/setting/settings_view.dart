
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/setting/settings_viewmodel.dart';
import 'package:ismmart_vms/screens/shippings/shippings_view.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import '../bank/bank_profile_view.dart';
import '../location_list/location_list_view.dart';
import '../payout_list/payout_list_view.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .24,
            color: Colors.greenAccent,
            child: Stack(
              children: [
                Positioned(
                    left: 30,
                    top: 180,
                    child: CustomText(
                      title: "Hasnain Mirrani",
                      size: 14,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: newColorDarkBlack2,
                      ),
                    )),
                Positioned(
                    left: 30,
                    top: 200,
                    child: CustomText(
                      title: "hmirrani@gmail.com",
                      size: 14,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: newColorDarkBlack2,
                      ),
                    )),
                Positioned(
                    left: 180,
                    top: 120,
                    child: CustomText(
                      title: "Seetings",
                      size: 14,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.dmSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: newColorDarkBlack2,
                      ),
                    )),
                const Positioned(
                  left: 40,
                  top: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,

                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ), //Text
                  ),
                ),
                Positioned(left: 20, top: 50, child: titleAndBackBtn()),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' Profile '),
            onTap: () {
              //Navigator.pop(context);
              //Get.to(() => VendorProfileDetailView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Store '),
            onTap: () {
              // Get.to(StoreView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('Payouts'),
            onTap: () {
              Get.to(() => PayoutListView());
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
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('Address'),
            onTap: () {
              //Navigator.pop(context);
              Get.to(() => LocationListView());
            },
          ),
        ],
      ),
    );
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: 40,
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
