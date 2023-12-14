import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:path/path.dart';
import '../../helper/constants.dart';
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
                      children: <Widget>[
                        titleAndBackBtn(),
                        storeLogo(),
                        nameField(),
                        storeTypeField(),
                        adressField(),
                        slugField(),
                        multipleSelectChip()
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
          CustomBackButton(onTap: () {
            Get.back();
          }),
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

  Widget storeTypeField() {
    return Obx(
      () => Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            title: "Store Type",
            size: 14,
            textAlign: TextAlign.start,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newColorDarkBlack2,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topLeft, child: viewModel.storeTypeDrowpDown())
      ]),
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

  //Multliple select chips
  Widget multipleSelectChip() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            title: "Please chose Store Type tags",
            size: 14,
            textAlign: TextAlign.start,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newColorDarkBlack2,
            ),
          ),
        ),
        Obx(
          () => Wrap(
            children: viewModel.hobbyList.value.map(
              (hobby) {
                if (viewModel.selectedHobby!.value.contains(hobby)) {
                  print(
                      "chip list  =====${viewModel.hobbyList}   ${viewModel.isSelected.value}");
                } else {}
                return GestureDetector(
                  onTap: () {
                    // viewModel.selectedHobby!.value.clear();
                    if (viewModel.selectedHobby!.value.contains(hobby)) {
                      viewModel.selectedHobby!.value!
                          .removeWhere((element) => element == hobby);
                      viewModel.selectedHobby?.refresh();
                      print("selected hobby ===== $hobby ");
                    } else {
                      if (viewModel.selectedHobby!.value.length < 6) {
                        viewModel.selectedHobby?.value.add(hobby);
                        viewModel.selectedHobby?.refresh();
                      }
                    }
                    print(
                        "selected hobby ===== $hobby  ${viewModel.selectedHobby!.value}");
                  },
                  child: Obx(
                    () => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          decoration: BoxDecoration(
                              color:
                                  viewModel.selectedHobby!.value.contains(hobby)
                                      ? Colors.black
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                  color: viewModel.selectedHobby!.value
                                          .contains(hobby)
                                      ? Colors.yellow
                                      : Colors.black,
                                  width: 2)),
                          child: Text(
                            hobby,
                            style: TextStyle(
                                color: viewModel.selectedHobby!.value
                                        .contains(hobby)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14),
                          ),
                        )),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
