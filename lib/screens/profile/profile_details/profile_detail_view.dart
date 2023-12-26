import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/profile/edit_profile_viewmodel.dart';
import 'package:ismmart_vms/screens/profile/widget/user_image_picker_widget.dart';

import 'package:ismmart_vms/widgets/custom_button.dart';

import '../edit_profile_view.dart';

class VendorProfileDetailView extends StatelessWidget {
  VendorProfileDetailView({super.key});
  final VendorProfileViewModel viewModel = Get.put(VendorProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleAndBackBtn(),
                  const SizedBox(
                    height: 40,
                  ),
                  UserImagePicker((pickedImage) => null),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      'Personal Info',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.1),
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildField("Name", "Farhaad Khan"),
                        _buildField("Email", "farhad@gmail.com"),
                        _buildField("Phone", "+923409+508537"),
                        _buildField("Gender", "Male"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Contact Info',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.1),
                        borderRadius: BorderRadius.circular(14)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildField("CNIC Number", "Farhaad Khan"),
                        _buildField("Password", "***********"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  editBtn()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Profile Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomBackButton(onTap: () {
            Get.back();
          }),
        ],
      ),
    );
  }

  Widget editBtn() {
    return CustomRoundedTextBtn(
      title: 'Edit',
      onPressed: () {
        Get.to(() => VendorProfileView());
      },
    );
  }

  Widget _buildField(String field1, String field2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(field1),
          Text(field2),
        ],
      ),
    );
  }
}
