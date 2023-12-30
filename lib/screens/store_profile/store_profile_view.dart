import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/store_profile/store_profile_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/loader_view.dart';

import '../../helper/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_checkbox_list_tile.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/pick_image.dart';

class StoreProfileView extends StatelessWidget {
  StoreProfileView({super.key});

  final StoreProfileViewModel viewModel = Get.put(StoreProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(title: 'Store'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: viewModel.storeFormKey,
              child: Column(
                children: [
                  profileImage(),
                  storeNameField(),
                  storeSlug(),
                  const SizedBox(height: 18),
                  storeType(),
                  Obx(
                    () => Wrap(
                      children: viewModel.filteredStoreTypeList
                          .map(
                            (e) => e.isSelected == true
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    margin: const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(e.name ?? ''),
                                  )
                                : const SizedBox(),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: CustomTextBtn(
                      title: 'Update',
                      onPressed: () {
                        viewModel.saveAndCreateBtn();
                      },
                    ),
                  ),
                  CustomTextBtn(
                    title: 'Discard',
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Get.back();
                    },
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
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Obx(
            () => (viewModel.storeProfileImage.value.path != "")
                ? Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(viewModel.storeProfileImage.value),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                : CachedNetworkImage(
                    height: 80,
                    width: 80,
                    imageUrl:
                        viewModel.userProfileModel.value.store?.logo ?? '',
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
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
        InkWell(
          onTap: () async {
            viewModel.storeProfileImage.value =
                await PickImage().pickSingleImage() ?? File('');
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
      ],
    );
  }

  Widget storeNameField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, top: 35),
      child: CustomTextField1(
        title: 'Store Name',
        hintText: 'ISMMART',
        controller: viewModel.storeNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator.validateDefaultField(value);
        },
      ),
    );
  }

  Widget storeSlug() {
    return CustomTextField1(
      title: 'Store Slug',
      hintText: '/ ismmartshop',
      controller: viewModel.storeSlugController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
    );
  }

  Widget storeType() {
    return CustomTextField1(
      isDropDown: true,
      title: 'Store Type',
      hintText: 'Home Decor',
      controller: viewModel.storeTypeController,
      // autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator.validateDefaultField(value);
      // },
      onTap: () {
        itemsBottomSheet();
      },
    );
  }

  //////////////
  itemsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Sources',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.5,
                    ),
                  ),
                  Obx(
                    () => CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      radius: 4,
                      width: 100,
                      child: Text(viewModel.selectAllValue.value
                          ? 'Unselect'
                          : 'Select All'),
                      onPressed: () {
                        viewModel.selectAllItems();
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: Obx(
                  () => viewModel.filteredStoreTypeList.isNotEmpty
                      ? ListView.builder(
                          itemCount: viewModel.filteredStoreTypeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => CheckBoxListTile1(
                                title: viewModel
                                        .filteredStoreTypeList[index].name ??
                                    '',
                                value: viewModel
                                    .filteredStoreTypeList[index].isSelected ?? false,
                                isSelected: viewModel
                                    .filteredStoreTypeList[index].isSelected ?? false,
                                onChanged: (value) {
                                  viewModel.selectSingleItem(value, index);
                                },
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No Data Found'),
                        ),
                ),
              ),
              const Divider(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextBtn(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Get.theme.primaryColor,
                      radius: 4,
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
