// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ismmart_vms/helper/constants.dart';
// import 'package:ismmart_vms/helper/languages/translations_key.dart';
// import 'package:ismmart_vms/helper/utils/image_constant.dart';
// import 'package:ismmart_vms/helper/utils/size_utils.dart';
// import 'package:ismmart_vms/widgets/custom_image_view.dart';
//
// import '../helper/resourses/app_colors.dart';
//
// class CustomBottomBar extends StatelessWidget {
//   const CustomBottomBar(
//       {super.key, required this.onTap, required this.currentIndex});
//   final ValueChanged<int>? onTap;
//   final int? currentIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Container(
//         height: 64.v,
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           borderRadius: BorderRadius.circular(32.h),
//           border: Border.all(
//             color: kGrey600,
//             width: 1.h,
//           ),
//         ),
//         // child: BottomNavigationBar(
//         //   backgroundColor: Colors.transparent,
//         //   showSelectedLabels: false,
//         //   showUnselectedLabels: false,
//         //   selectedFontSize: 0,
//         //   elevation: 0,
//         //   currentIndex: currentIndex!,
//         //   items: [
//         //     //"assets/svg/img_home.svg"
//         //     _bottomBarItem(iconImage: ImageConstant.imgHome),
//         //     _bottomBarItem(iconImage: ImageConstant.imgBag),
//         //     _bottomBarItem(iconImage: ImageConstant.imgPlus),
//         //     _bottomBarItem(iconImage: ImageConstant.imgTag),
//         //     _bottomBarItem(iconImage: ImageConstant.imgAvatar),
//         //   ],
//         //   onTap: onTap,
//         // ),
//
//       ),
//     );
//   }
//
//   // BottomNavigationBarItem _bottomBarItem({iconImage, color}) {
//   //   return BottomNavigationBarItem(
//   //     icon: CustomImageView(
//   //       imagePath: iconImage,
//   //       height: 24.adaptSize,
//   //       width: 24.adaptSize,
//   //       color: color ?? kGrey600,
//   //     ),
//   //     activeIcon: CustomImageView(
//   //       imagePath: iconImage,
//   //       height: 24.adaptSize,
//   //       width: 24.adaptSize,
//   //       color: blueA700,
//   //     ),
//   //     label: '',
//   //   );
//   // }
//
//   Widget bottomNavigationBar(BuildContext context) {
//     return Obx(
//           () => ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//         child: BottomAppBar(
//           notchMargin: 9,
//           shape: const CircularNotchedRectangle(),
//           child: Row(
//             children: [
//               bottomNavigationItem(
//                 context,
//                 icon: CupertinoIcons.home,
//                 selected:
//                 GlobalVariable.selectedIndex.value == 0 ? true : false,
//                 onTap: () {
//                   viewModel.goToHome();
//                   // GlobalVariable.selectedIndex.value = 0;
//                 },
//                 name: 'Home',
//               ),
//               bottomNavigationItem(
//                 context,
//                 icon: CupertinoIcons.doc_text,
//                 selected:
//                 GlobalVariable.selectedIndex.value == 1 ? true : false,
//                 onTap: () {
//                   viewModel.goToLeadSheet();
//                 },
//                 name: 'Search',
//               ),
//               const Expanded(
//                 child: SizedBox(
//                   height: 0,
//                 ),
//               ),
//               bottomNavigationItem(
//                 context,
//                 icon: CupertinoIcons.bell,
//                 selected:
//                 GlobalVariable.selectedIndex.value == 2 ? true : false,
//                 onTap: () {
//                   GlobalVariable.selectedIndex.value = 2;
//                 },
//                 name: 'Message',
//               ),
//               bottomNavigationItem(
//                 context,
//                 icon: CupertinoIcons.list_dash,
//                 selected: false,
//                 onTap: () {
//                   showMenuBottomSheet();
//                 },
//                 name: 'Account',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget bottomNavigationItem(
//       BuildContext context, {
//         required bool selected,
//         required GestureTapCallback onTap,
//         required IconData icon,
//         required String name,
//       }) {
//     return Expanded(
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           customBorder: const StadiumBorder(),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 19),
//             child: Icon(
//               icon,
//               size: 25,
//               color: selected
//                   ? (context.isDarkMode
//                   ? Colors.white
//                   : ThemeColors.lightPrimaryColor)
//                   : ThemeColors.dark3.withOpacity(0.5),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
