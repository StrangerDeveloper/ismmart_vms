import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:path/path.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/image_layout_container.dart';
import '../../widgets/pick_image.dart';

class StoreView extends StatelessWidget {
  StoreView({super.key});
  final StoreViewModel viewModel = Get.put(StoreViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.signUpFormKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleAndBackBtn(),
                        storeLogo(),
                        nameField(),
                        adressField(),
                        slugField()
                      ],
                    ),
                  ),
                ),
              ],
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
              'Store Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          CustomBackButton(onTap: () {}),
        ],
      ),
    );
  }

  Widget nameField() {
    return CustomTextField3(
      title: 'Store Name',
      hintText: 'My Stores Mart',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }

  Widget slugField() {
    return CustomTextField3(
      title: 'Store Slug',
      hintText: 'Store Slug (Non repeatable)',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }

  Widget storeLogo() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'Store Logo',
        filePath: viewModel.logoImage.value == ''
            ? ''
            : basename(viewModel.logoImage.value),
        onTap: () async {
          await viewModel.selectImage(
              viewModel.logoImage, viewModel.logoImageErrorVisibility);
        },
        errorVisibility: viewModel.logoImageErrorVisibility.value,
        errorPrompt: 'Logo Image is required',
      ),
    );
  }

  Widget adressField() {
    return CustomTextField3(
      title: 'Adress',
      hintText: 'My Stores Adress',
      controller: viewModel.nameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.FirstNameReq.tr);
      // },
    );
  }
}
