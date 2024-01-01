import 'package:flutter/material.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/utils/image_constant.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/widgets/custom_image_view.dart';

import '../helper/resourses/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar(
      {super.key, required this.onTap, required this.currentIndex});
  final ValueChanged<int>? onTap;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.v,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(32.h),
        border: Border.all(
          color: kGrey600,
          width: 1.h,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: kWhiteColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: currentIndex!,
        items: [
          //"assets/svg/img_home.svg"
          _bottomBarItem(iconImage: ImageConstant.imgHome),
          _bottomBarItem(iconImage: ImageConstant.imgBag),
          _bottomBarItem(iconImage: ImageConstant.imgPlus),
          _bottomBarItem(iconImage: ImageConstant.imgTag),
          _bottomBarItem(iconImage: ImageConstant.imgAvatar),
        ],
        onTap: onTap,
      ),
    );
  }

  BottomNavigationBarItem _bottomBarItem({iconImage}) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: CustomImageView(
        imagePath: iconImage,
        height: 24.adaptSize,
        width: 24.adaptSize,
        color: kGrey400,
      ),
      activeIcon: CustomImageView(
        imagePath: iconImage,
        height: 24.adaptSize,
        width: 24.adaptSize,
        color: blueA700,
      ),
      label: '',
    );
  }
}
