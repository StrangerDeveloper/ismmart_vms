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
                    imageUrl: viewModel.userProfileModel.value.store?.logo !=
                            null
                        ? '${viewModel.userProfileModel.value.store!.logo}?datetime=${DateTime.now().millisecondsSinceEpoch}'
                        : '',
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
          return Validator.validateDefaultField(value, errorMessage: 'Store Name is required');
        },
      ),
    );
  }

  Widget storeSlug() {
    return CustomTextField1(
      title: 'Store Slug',
      hintText: 'ismmartshop',
      controller: viewModel.storeSlugController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value, errorMessage: 'Store Slug is required');
      },
    );
  }

  Widget storeType() {
    return InkWell(
      onTap: () {
        itemsBottomSheet();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Store Type',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: ThemeHelper.grey3,
              border: Border.all(color: ThemeHelper.grey1, width: 1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Obx(
              () => viewModel.storeTypeList
                      .where((element) => element.isSelected == true)
                      .isNotEmpty
                  ? Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: viewModel.storeTypeList
                          .map(
                            (e) => e.isSelected == true
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEFF5FB),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: ThemeHelper.grey2,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          )
                          .toList(),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(left: 2, top: 5, bottom: 5),
                      child: Text(
                        'Home Decor',
                        style: TextStyle(
                          color: ThemeHelper.grey2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  itemsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: ThemeHelper.blue1,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Store Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeHelper.blue1,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
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
                  () => viewModel.storeTypeList.isNotEmpty
                      ? ListView.builder(
                          itemCount: viewModel.storeTypeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => CheckBoxListTile1(
                                title:
                                    viewModel.storeTypeList[index].name ?? '',
                                value:
                                    viewModel.storeTypeList[index].isSelected ??
                                        false,
                                isSelected:
                                    viewModel.storeTypeList[index].isSelected ??
                                        false,
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
