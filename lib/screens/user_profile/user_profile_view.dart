import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/user_profile/user_profile_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/theme_helper.dart';
import '../../widgets/custom_button.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  final UserProfileViewModel viewModel = Get.put(UserProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Profile Details',
      ),
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
                      item1("Name", "Farhaad Khan"),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: item1("Email", "farhad@gmail.com"),
                      ),
                      item1("Phone", "+923409+508537"),
                      const SizedBox(height: 25),
                      item1("Gender", "Male"),
                    ],
                  ),
                  headingItem('Contact Info'),
                  containerDecoration(
                    children: [
                      item1("CNIC Number", "Farhaad Khan"),
                      const SizedBox(height: 25),
                      item1("Password", "***********"),
                    ],
                  ),
                  SizedBox(height: 25),
                  CustomTextBtn(
                    title: 'Edit',
                    backgroundColor: Colors.transparent,
                    foregroundColor: ThemeHelper.blue1,
                    onPressed: () {},
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Obx(
              () => (viewModel.pickedFile.value.path != "")
                  ? Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(viewModel.pickedFile.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      height: 80,
                      width: 80,
                      imageUrl: '',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/logo/logo_new.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        );
                      },
                    ),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 4,
            child: InkWell(
              onTap: () {
                // showPicker(context);
              },
              child: Container(
                padding: const EdgeInsets.all(3.5),
                decoration: BoxDecoration(
                  color: ThemeHelper.blue1,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.8),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
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

  Widget item1(String field1, String field2) {
    return Row(
      children: [
        Text(
          field1,
          style: const TextStyle(
            color: ThemeHelper.grey5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            field2,
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
}
