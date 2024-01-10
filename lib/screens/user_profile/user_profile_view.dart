import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/edit_user_profile/edit_user_profile_view.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_cached_network_image.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/theme_helper.dart';
import '../../widgets/custom_button.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  final UserProfileViewModel viewModel = Get.put(UserProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileImage(),
                  headingItem('Personal Info'),
                  containerDecoration(
                    children: [
                      Obx(
                        () => item1(
                          title: "Name",
                          value: viewModel.userProfileModel.value.name ?? 'N/A',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Obx(
                          () => item1(
                            title: "Email",
                            value:
                                viewModel.userProfileModel.value.email ?? 'N/A',
                          ),
                        ),
                      ),
                      Obx(
                        () => item1(
                          title: "Phone",
                          value:
                              viewModel.userProfileModel.value.phone ?? 'N/A',
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => item1(
                          title: "Gender",
                          value:
                              viewModel.userProfileModel.value.gender ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                  headingItem('Contact Info'),
                  containerDecoration(
                    children: [
                      Obx(
                        () => item1(
                          title: "CNIC Number",
                          value: viewModel.userProfileModel.value.cnic ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  editBtn(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Align(
      alignment: Alignment.center,
      child: Obx(() => CustomCachedNetworkImage(
            imageUrl: viewModel.userProfileModel.value.image != null
                ? viewModel.userProfileModel.value.image!
                : '',
          )),
    );
  }

  Widget headingItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 15),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: ThemeHelper.grey5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget item1({required String title, required String value}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ThemeHelper.grey5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: ThemeHelper.blue1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget containerDecoration({List<Widget> children = const <Widget>[]}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget editBtn() {
    return CustomTextBtn(
      title: 'Edit',
      backgroundColor: Colors.transparent,
      foregroundColor: ThemeHelper.blue1,
      onPressed: () {
        Get.to(() => EditUserProfileView(),
            arguments: {'model': viewModel.userProfileModel});
      },
      child: const Text(
        'Edit',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
