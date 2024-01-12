import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/screens/bank_list/bank_list_view.dart';
import 'package:ismmart_vms/screens/drawer_bottom_nav/drawer_bottom_bar_view.dart';
import 'package:ismmart_vms/screens/location_list/location_list_view.dart';
import 'package:ismmart_vms/screens/order_listing/order_view.dart';
import 'package:ismmart_vms/screens/product_list/product_list_view.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_cached_network_image.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import '../screens/dashboard/dashboard_viewmodel.dart';
import '../screens/store_profile/store_profile_view.dart';
import '../screens/user_profile/user_profile_view.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Drawer(
        width: Get.width * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              //padding: EdgeInsets.zero,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                titleAndBackBtn(
                    onTap: () {
                      Get.back();
                      Get.to(() => StoreProfileView());
                    },
                    iconPath: viewModel.userProfileModel.value.store?.logo,
                    title: viewModel.userProfileModel.value.store?.name ??
                        'ISMMART',
                    top: 30.0,
                    hasMenu: false),
                drawerListItems(
                  'Overview',
                  onTab: () {
                    Get.back();
                    Get.to(() => DrawerBottomBarView());
                  },
                  iconPath: 'assets/icons/overViewIcon.png',
                ),
                drawerListItems(
                    //iconPath: 'assets/icons/settingIcon.png',
                    iconPath: null,
                    icon: Icons.shopping_bag_rounded,
                    'Orders',
                    onTab: () => viewModel.orderMoreOption.toggle(),
                    dropDwnIcon: true),

                Obx(
                  () => viewModel.orderMoreOption.value
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              drawerListItems('Returned', h: 25, onTab: () {
                                Get.back();
                                Get.to(() => OrderView(
                                      callingFor: "Returned",
                                    ));
                              }),
                              drawerListItems('Cancelled', h: 25, onTab: () {
                                Get.back();
                                Get.to(() => OrderView(
                                      callingFor: "Cancelled",
                                    ));
                              }),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),

                drawerListItems(
                  'Product',
                  //iconPath: 'assets/icons/pin.png',
                  hasProdCount: true,

                  icon: Icons.local_offer_rounded,
                  onTab: () {
                    Get.back();
                    GlobalVariable.selectedIndex.value = 3;
                  },
                ),

                drawerListItems('Locations', iconPath: 'assets/icons/pin.png',
                    onTab: () {
                  Get.back();
                  Get.to(() => LocationListView());
                }),
                const Divider(
                  color: Color(0xffE5E7EB),
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  // height: 20
                ),
                // drawerListItems('Payouts',
                //     iconPath: 'assets/icons/credit-card.png',
                //     onTab: () => Get.to(PayoutListView())),
                drawerListItems(
                    //iconPath: 'assets/icons/settingIcon.png',
                    icon: Icons.settings,
                    'Settings',
                    onTab: () => viewModel.moreOption.toggle(),
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
                                  h: 25, onTab: () {
                                Get.back();
                                Get.to(() => BankListView());
                              }),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (viewModel.rejected.value == 'rejected') {
                        Get.to(() => UserProfileView());
                      } else {
                        Get.back();
                        GlobalVariable.selectedIndex.value = 4;
                      }
                    },
                    child: titleAndBackBtn(
                        top: 10.0,
                        iconPath: viewModel.userProfileModel.value.image,
                        title: viewModel.userProfileModel.value.name ?? ''),
                  ),
                  drawerListItems('Logout', icon: Icons.exit_to_app, onTab: () {
                    final box = GetStorage();
                    box.write('islogin', false);
                    viewModel.logout();
                  }),
                  const Divider(
                    color: Color(0xffE5E7EB),
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                    // height: 20
                  ),
                  _allRightReservedMsg(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleAndBackBtn({iconPath, title, hasMenu = false, top, onTap}) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: 15, bottom: 5, right: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
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
                  // Image.asset(
                  //   iconPath,
                  //   height: 40,
                  //   width: 40,
                  // ),
                  CustomCachedNetworkImage(
                    imageUrl: iconPath,
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: 20.v,
                  ),
                  Text(
                    title,
                    style: newFontStyleSize12.copyWith(
                        fontWeight: FontWeight.w700),
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
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined))
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerListItems(String title,
      {String? iconPath,
      bool? dropDwnIcon,
      IconData? icon,
      double h = 50.0,
      hasProdCount = false,
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
                      ? Image.asset(
                          iconPath,
                          height: 24,
                          width: 24,
                          color: viewModel.isTab.value
                              ? newColorBlue
                              : newColorLightGrey2,
                        )
                      : Icon(icon, size: 24, color: ThemeHelper.lightGrey),
                  // ? Obx(() => Image.asset(
                  //       iconPath,
                  //       height: 24,
                  //       width: 24,
                  //       color: viewModel.isTab.value
                  //           ? newColorBlue
                  //           : newColorLightGrey2,
                  //     ))
                  // : Container(),
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
                        if (icon == Icons.settings) {
                          viewModel.moreOption.toggle();
                        } else {
                          viewModel.orderMoreOption.toggle();
                        }
                      },
                      icon: const Icon(Icons.arrow_drop_down))
                  : hasProdCount
                      ? Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: CustomText(
                            title: Get.put(ProductListViewModel())
                                .dataList
                                .length
                                .toString(),
                            color: Colors.white,
                            size: 12,
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _allRightReservedMsg() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CustomText(
          title: 'Copyrights© ${DateTime.now().year} ISMMART',
          size: 11,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }
}
