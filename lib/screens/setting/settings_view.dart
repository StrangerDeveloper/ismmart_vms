import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_view.dart';
import 'package:ismmart_vms/screens/setting/settings_viewmodel.dart';
import 'package:ismmart_vms/screens/store_profile/store_profile_view.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_view.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';
import 'package:ismmart_vms/widgets/scrollable_column.dart';

import '../../helper/common_function.dart';
import '../../widgets/custom_cached_network_image.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar2(title: 'Settings'),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ScrollableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gradientContainer(),
              const Text(
                'User Personalization',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 13),
              settingItem(
                icon: Icons.perm_identity_rounded,
                title: 'User Profile',
                startRadius: true,
                onTap: () {
                  Get.to(() => UserProfileView(), arguments: {'showAppBar' : true});
                },
              ),
              customDivider(),
              settingItem(
                icon: Icons.storefront_sharp,
                title: 'Shop Profile',
                onTap: () {
                  Get.to(() => StoreProfileView());
                },
              ),
              customDivider(),
              settingItem(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Bank List',
                endRadius: true,
                onTap: () {
                  Get.to(() => BankListView());
                },
              ),
              const Spacer(),
              CustomIconTextBtn(
                foregroundColor: ThemeHelper.blue1,
                backgroundColor: const Color(0xFFF7F7F7),
                radius: 30,
                height: 50,
                onPressed: () {
                  CommonFunction.logout();
                },
                title: 'Logout',
                icon: Icons.logout_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gradientContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 50),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xff6d8ac5), Color(0xff3669c9), Color(0xff6895e8)],
            stops: [0.25, 0.40, 0.87],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
      child: Row(
        children: [
          Obx(
            () => CustomCachedNetworkImage(
              imageUrl: viewModel.userProfileModel.value.image ?? '',
              height: 30,
              width: 30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    viewModel.userProfileModel.value.name ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    viewModel.userProfileModel.value.status ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget settingItem({
    required IconData icon,
    required String title,
    bool startRadius = false,
    bool endRadius = false,
    required void Function() onTap,
  }) {
    BorderRadius borderRadius = BorderRadius.vertical(
      top: startRadius == true ? const Radius.circular(10) : Radius.zero,
      bottom: endRadius == true ? const Radius.circular(10) : Radius.zero,
    );
    return Material(
      color: const Color(0xFFF7F7F7),
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Icon(
                icon,
                color: ThemeHelper.blue1,
                size: 21,
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.5),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF393939),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 0,
      color: Color(0xFFE3E3E3),
    );
  }
}
