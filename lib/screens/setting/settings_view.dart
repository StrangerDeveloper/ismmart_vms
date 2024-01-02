import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/utils/image_constant.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/auth/login/login_view.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_view.dart';
import 'package:ismmart_vms/screens/shippings/shippings_view.dart';
import 'package:ismmart_vms/screens/store_profile/store_profile_view.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_view.dart';

import '../../helper/constants.dart';
import '../add_location/add_location_view.dart';
import '../add_user/add_user_view.dart';
import '../collection/collection_view.dart';
import '../dashboard/dashboard_viewmodel.dart';
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
            titleAndBackBtn(
                iconPath: 'assets/images/ismmart_logo.png',
                title: 'ISMMART',
                hasMenu: true),

            SizedBox(
              height: 30.h,
            ),
            // drawerHeader(),
            drawerListItems(
              'Store',
              onTab: () {
                //viewModel.isTab.value = !viewModel.isTab.value;
                Get.to(StoreProfileView());
              },
              iconPath: 'assets/images/overViewIcon.png',
            ),

            drawerListItems(
              'Collections',
              iconPath: 'assets/images/layers.png',
              // onTab: () => Get.to(CollectionView()),
            ),

            drawerListItems(
              'Locations',
              iconPath: 'assets/images/pin.png',
              onTab: () => Get.to(AddLocationView()),
            ),

            const Divider(
              color: Color(0xffE5E7EB),
              thickness: 2,
              indent: 15,
              endIndent: 15,
              // height: 20
            ),
            const SizedBox(
              height: 10,
            ),
            drawerListItems('Payouts',
                iconPath: 'assets/images/credit-card.png',
                onTab: () => Get.to(PayoutListView())),
            drawerListItems(
                //iconPath: 'assets/images/settingIcon.png',
                onTab: () {
              viewModel.moreOption.toggle();
            }, 'Settings', dropDwnIcon: true),

            Obx(
              () => viewModel.moreOption.value
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          drawerListItems(
                            iconPath: 'assets/images/wallet.png',
                            'Banking',
                            h: 45,
                            onTab: () => Get.to(BankListView()),
                          ),
                          drawerListItems(
                              iconPath: 'assets/images/Vector.png',
                              'Shipping',
                              h: 45,
                              onTab: () => Get.to(ShippingMethodsView())),
                          drawerListItems(
                              iconPath: 'assets/images/edit-user.png',
                              'Users & Permissions',
                              h: 45,
                              onTab: () => Get.to(AddUserView())),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),

            InkWell(
              onTap: () => Get.to(UserProfileView()),
              child: titleAndBackBtn(
                  iconPath: ImageConstant.imgAvatar, title: 'User Name'),
            ),

            drawerListItems('Logout', iconPath: 'assets/images/settingIcon.png',
                onTab: () {
              Get.offAll(LogInView());
            })
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

  Widget titleAndBackBtn({iconPath, title, hasMenu = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 15, bottom: 5, right: 15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  iconPath,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 30.v,
                ),
                Text(
                  title,
                  style:
                      newFontStyleSize12.copyWith(fontWeight: FontWeight.w700),
                ),
                // Align(
                //   alignment: Alignment.,
                //   child:
                // ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            if (hasMenu)
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
          //width: double.infinity,
          height: h,
          padding: const EdgeInsets.all(5),
          decoration: ShapeDecoration(
            //color: const Color(0xFFEFF5FB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      : Container(),
                  SizedBox(width: 15.h),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      title,
                      style: newFontStyleSize16,
                    ),
                  ),
                  // SizedBox(
                  //   width: Get.width * 0.55,
                  // ),
                ],
              ),
              dropDwnIcon ?? false
                  ? IconButton(
                      onPressed: () {
                        viewModel.moreOption.toggle();
                      },
                      icon: const Icon(Icons.arrow_drop_down))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
