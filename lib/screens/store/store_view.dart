import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/screens/store/store_viewmodel.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import 'package:path/path.dart' as p;
import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/image_layout_container.dart';

class StoreView extends StatelessWidget {
  StoreView({super.key});

  final StoreViewModel viewModel = Get.put(StoreViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Stack(
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
                          SizedBox(
                            height: 10,
                          ),
                          countryAndCityDrowpDown("Select Country"),
                          SizedBox(
                            height: 10,
                          ),
                          countryAndCityDrowpDown("Select City"),
                          SizedBox(
                            height: 10,
                          ),
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
            : p.basename(viewModel.logoImage.value),
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

  //Country and City Filed
  Widget countryAndCityDrowpDown(
    String title,
  ) {
    return Obx(
      () => Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            title: title ?? "Select Option",
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
            children: viewModel.hobbyList.map(
              (hobby) {
                if (viewModel.selectedHobby!.contains(hobby)) {
                  print(
                      "chip list  =====${viewModel.hobbyList}   ${viewModel.isSelected.value}");
                } else {}
                return GestureDetector(
                  onTap: () {
                    if (viewModel.selectedHobby!.contains(hobby)) {
                      viewModel.selectedHobby!
                          .removeWhere((element) => element == hobby);
                      viewModel.selectedHobby?.refresh();
                      print("selected hobby ===== $hobby ");
                    } else {
                      if (viewModel.selectedHobby!.length < 6) {
                        viewModel.selectedHobby?.add(hobby);
                        viewModel.selectedHobby?.refresh();
                      }
                    }

                    print(
                        "selected hobby ===== $hobby  ${viewModel.selectedHobby!}");
                  },
                  child: Obx(
                    () => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 12),
                          decoration: BoxDecoration(
                              color: viewModel.selectedHobby!.contains(hobby)
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                  color:
                                      viewModel.selectedHobby!.contains(hobby)
                                          ? Colors.yellow
                                          : Colors.black,
                                  width: 2)),
                          child: Text(
                            hobby,
                            style: TextStyle(
                                color: viewModel.selectedHobby!.contains(hobby)
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
