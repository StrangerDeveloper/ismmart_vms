import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/drawer_bottom_nav/drawer_bottom_bar_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_cached_network_image.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';

import '../../helper/global_variables.dart';

class DrawerBottomBarView extends StatelessWidget {
  DrawerBottomBarView({super.key, this.child});

  final Widget? child;
  final DrawerBottomBarViewModel viewModel =
      Get.put(DrawerBottomBarViewModel());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        viewModel.onBackPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              viewModel.appBarTitle(GlobalVariable.selectedIndex.value),
            ),
          ),
          actions: [
            bellIcon(),
          ],
        ),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        drawer: CustomDrawer(),
        body: Obx(
          () => viewModel.selectView(GlobalVariable.selectedIndex.value),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Widget bellIcon() {
    return Obx(
      () => GlobalVariable.selectedIndex.value == 0
          ? IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          : const SizedBox(),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: const Color(0xffE5E7EB)),
            ),
            child: Row(
              children: [
                bottomNavigationItem(
                  context,
                  icon: Icons.home_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 0 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 0;
                  },
                  toolTip: 'Home',
                ),
                bottomNavigationItem(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 1 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 1;
                  },
                  toolTip: 'Cart',
                ),
                bottomNavigationItem(
                  context,
                  fontSize: 40,
                  padding: 1,
                  icon: Icons.add_circle_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 2 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 2;
                  },
                  toolTip: 'Add',
                ),
                bottomNavigationItem(
                  context,
                  icon: Icons.local_offer_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 3 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 3;
                  },
                  toolTip: 'Tag',
                ),
                bottomNavigationItem(
                  context,
                  icon: CupertinoIcons.list_dash,
                  selected:
                      GlobalVariable.selectedIndex.value == 4 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 4;
                  },
                  toolTip: 'Profile',
                  padding: 14,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CustomCachedNetworkImage(
                          height: 27,
                          width: 27,
                          fit: BoxFit.contain,
                          imageUrl: viewModel.userProfileModel.value.image),
                      Positioned(
                        //right: 0,
                        //right: 5,
                        top: -1,
                        //left: 0,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white, // Green background color
                          ),
                          // constraints: const BoxConstraints(
                          //   minWidth: 8,
                          //   minHeight: 8,
                          // ),
                          child: const Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationItem(
    BuildContext context, {
    required bool selected,
    required GestureTapCallback onTap,
    required IconData icon,
    required String toolTip,
    double fontSize = 24,
    double padding = 15,
    Widget? child,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Tooltip(
          message: toolTip,
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: child ??
                  Icon(
                    icon,
                    size: fontSize,
                    color: selected ? ThemeHelper.blue1 : ThemeHelper.lightGrey,
                    // shadows: selected
                    //     ? const [
                    //         BoxShadow(
                    //           color: ThemeHelper.blue1,
                    //           blurRadius: 3,
                    //           offset: Offset(1, 1),
                    //           spreadRadius: 5,
                    //         )
                    //       ]
                    //     : null,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
