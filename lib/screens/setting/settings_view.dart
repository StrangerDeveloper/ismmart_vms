import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/setting/settings_viewmodel.dart';
import 'package:ismmart_vms/screens/shippings/shippings_view.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';

import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import '../add_location/add_location_view.dart';
import '../add_user/add_user_view.dart';
import '../collection/collection_list_view.dart';
import '../collection/collection_view.dart';
import '../dashboard/dashboard_viewmodel.dart';
import '../location_list/location_list_view.dart';
import '../payout_list/payout_list_view.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleAndBackBtn(),
            // drawerHeader(),
            drawerListItems(
              'Store',
              onTab: () {
                viewModel.isTab.value = !viewModel.isTab.value;
                //  Get.to(StoresView());
              },
              iconPath: 'assets/icons/overViewIcon.png',
            ),
            drawerListItems(
              'Collections',
              iconPath: 'assets/icons/layers.png',
              onTab: () => Get.to(CollectionListView()),
            ),
            drawerListItems('Locations',
                iconPath: 'assets/icons/pin.png',
                onTab: () => Get.to(AddLocationView())),
            const Divider(
              color: Color(0xffE5E7EB),
              thickness: 2,
              indent: 15,
              endIndent: 15,
              // height: 20
            ),
            SizedBox(
              height: 10,
            ),
            drawerListItems('Payouts',
                iconPath: 'assets/icons/credit-card.png',
                onTab: () => Get.to(PayoutListView())),
            drawerListItems(
                iconPath: 'assets/icons/settingIcon.png',
                'Settings and privacy',
                dropDwnIcon: true),

            Obx(
              () => viewModel.moreOption.value
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          drawerListItems(
                            iconPath: 'assets/icons/wallet.png',
                            'Banking',
                            h: 45,
                            // onTab: () => Get.to(Bank()),
                          ),
                          drawerListItems(
                              iconPath: 'assets/icons/Vector.png',
                              'Shipping',
                              h: 45,
                              onTab: () => Get.to(ShippingMethodsView())),
                          drawerListItems(
                              iconPath: 'assets/icons/edit-user.png',
                              'Users & Permissions',
                              h: 45,
                              onTab: () => Get.to(AddUserView())),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),

            drawerListItems(
              'Logout',
              onTab: () {
                viewModel.isTab.value = !viewModel.isTab.value;
                //  Get.to(StoresView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 75,
            width: 75,
            imageUrl: AppConstant.defaultImgUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey,
                  ));
            },
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 0.5),
              );
            },
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 2),
            child: Text(
              'Abc UserNAme',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 30),
        ],
      ),
    );
  }

  Widget drawerItem({
    String title = '',
    required IconData icon,
    double iconSize = 22,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 2,
      dense: true,
      contentPadding: const EdgeInsets.only(left: 22, top: 10, bottom: 10),
      leading: Icon(
        icon,
        size: iconSize,
        color: Colors.grey.shade500,
        //color: Get.theme.primaryColor.withOpacity(0.7),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

//   Widget drawerExpandableItem(
//       {String title = '',
//       required IconData icon,
//       double iconSize = 19,
//       required List<Widget> children}) {
//     return ListTileTheme(
//       horizontalTitleGap: -14,
//       dense: true,
//       child: ExpansionTile(
// // textColor: Color(0xff622260),
// // iconColor: Color(0xff622260),
//         tilePadding: EdgeInsets.only(left: 10, right: 20),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             fontFamily: 'Roboto-Regular',
// //fontWeight: FontWeight.w00
//           ),
//         ),
//         leading: Container(
//           child: Icon(
//             icon,
//             size: iconSize,
//             color: Colors.grey,
//           ),
//         ),
//         children: children,
//       ),
//     );
//   }

  Widget titleAndBackBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 15, bottom: 33, right: 15),
      child: Container(
        height: 54,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: const Color(0xFFEFF5FB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/icons/ismmart_logo.png',
              height: 40,
              width: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'ISMMART',
                style: newFontStyleSize12.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
          ],
        ),
      ),
    );
  }

  Widget drawerListItems(String title,
      {String? iconPath,
      bool? dropDwnIcon,
      double h = 54.0,
      void Function()? onTab}) {
    //bool isTab = false;
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 13, right: 15),
      child: GestureDetector(
        onTap: onTab,
        child: Container(
          //  width: Get.width * .8,
          height: h,
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconPath != null
                  ? Obx(() => Image.asset(
                        iconPath,
                        height: 24,
                        width: 24,
                        color: viewModel.isTab.value
                            ? newColorBlue
                            : newColorLightGrey2,
                      ))
                  : Icon(
                      Icons.logout,
                      size: 24,
                      color: Colors.red.shade300,
                    ),
              SizedBox(width: 20.h),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  style: newFontStyleSize16,
                ),
              ),
              SizedBox(
                width: Get.width * .25,
              ),
              dropDwnIcon ?? false
                  ? IconButton(
                      onPressed: () {
                        viewModel.moreOption.toggle();
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
