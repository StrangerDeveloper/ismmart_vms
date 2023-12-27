import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/drawer_bottom_nav/drawer_bottom_bar_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_drawer.dart';

import '../../widgets/custom_bottom_bar.dart';

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
        if (didPop) return;
        viewModel.onBackPressed(context);
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        body: PageView(
          controller: viewModel.bottomNavPageController,
          physics: const BouncingScrollPhysics(),
          children: viewModel.bottomNavScreens,
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Obx(
      () => CustomBottomBar(
        onTap: viewModel.changePage,
        currentIndex: viewModel.currentPageIndex.value,
      ),
    );
  }
}
