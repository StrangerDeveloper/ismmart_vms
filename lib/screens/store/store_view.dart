import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';

import '../../helper/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class StoreView extends StatelessWidget {
  StoreView({super.key});

  final StoreViewModel viewModel = Get.put(StoreViewModel());

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
                        // viewModel.saveAndCreateBtn();
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
            () => (viewModel.pickedFile.value.path != "")
                ? Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(viewModel.pickedFile.value),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                : CachedNetworkImage(
                    height: 80,
                    width: 80,
                    imageUrl: '',
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
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value);
      },
    );
  }
}
