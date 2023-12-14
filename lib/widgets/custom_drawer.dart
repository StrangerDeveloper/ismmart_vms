import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/screens/collection/collection_view.dart';
import '../screens/Order/order_view.dart';
import '../screens/auth/login/login_view.dart';
import '../screens/setting/settings_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Drawer(
            width: Get.width * 0.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  drawerHeader(),
                  drawerItem(
                    title: 'Dashboard',
                    icon: Icons.dashboard,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  drawerItem(
                    title: 'Collections',
                    icon: Icons.collections,
                    onTap: () {
                      Get.back();
                      Get.to(() => CollectionView());
                    },
                  ),
                  drawerItem(
                    title: 'Order Details',
                    icon: Icons.add_shopping_cart,
                    onTap: () {
                      Get.back();
                      Get.to(() => OrderView());
                    },
                  ),
                  drawerItem(
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {
                      Get.back();
                      Get.to(() => SettingsView());
                    },
                  ),

                  //drawerItem(
                  //   title: 'Shift Report',
                  //   icon: Icons.file_copy_sharp,
                  //   onTap: () {
                  //     Get.back();
                  //     Get.to(() => CashierShiftReportView());
                  //   },
                  // ),
                  drawerItem(
                    title: 'Logout',
                    icon: Icons.logout,
                    onTap: () {
                      Get.back();
                      Get.offAll(() => LogInView());
                    },
                  ),
                ],
              ),
            ),
          ),
          //const LoaderView()
        ],
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
}
