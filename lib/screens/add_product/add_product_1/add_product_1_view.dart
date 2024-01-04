import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/common_function.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_view.dart';
import 'package:ismmart_vms/widgets/custom_bottom_sheet2.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../helper/constants.dart';
import '../../../helper/theme_helper.dart';
import '../../../widgets/bottomsheet_item.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loader_view.dart';
import '../../../widgets/stepperText.dart';
import 'add_product_1_viewmodel.dart';

class AddProduct1View extends StatelessWidget {
  AddProduct1View({super.key});

  final AddProduct1ViewModel viewModel = Get.put(AddProduct1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                stepperText(),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      ///Upload Images Section
                      // _buildImageSection(),

                      ///Product Category Field
                      // Obx(() => selectCategoryField()),
                      //
                      // ///Product Sub Category Dropdown Field
                      // Obx(() => viewModel.subCategoriesList.isEmpty
                      //     ? Container()
                      //     : selectSubCategoryField()),

                      ///Product Category fields or variants or features

                      ///Product Basic Details
                      titleTxtField(),
                      descriptionField(),
                      mediaWidget(),
                      priceField(),
                      typeTxtField(),
                      categoryTxtField(),
                      tagsField(),
                      thisIsPhysicalProduct(),
                      CustomTextBtn(
                        onPressed: () {
                          Get.to(() => AddProduct2View());
                          // viewModel.creatingVariants();
                          // viewModel.addProdBtnPress();
                        },
                        title: 'Save & Continue',
                      ),
                      CustomTextBtn(
                        title: 'Back',
                        backgroundColor: Colors.black,
                        onPressed: () {},
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }


  Widget titleTxtField() {
    return CustomTextField1(
      title: 'Title',
      hintText: 'Product Name',
      controller: viewModel.prodTitleController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (value) {
      //   return Validator()
      //       .validateName(value, errorToPrompt: langKey.productNameReq.tr);
      // },
      keyboardType: TextInputType.name,
    );
  }

  Widget descriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: textContainerDecoration,
            child: Column(
              children: [
                ToolBar(
                  toolBarConfig: viewModel.customToolBarList,
                  controller: viewModel.prodDescriptionController,
                  toolBarColor: kDescriptionToolbarColor,
                  iconColor: const Color(0xff929AAB),
                ),
                QuillHtmlEditor(
                    hintTextAlign: TextAlign.center,
                    hintText: 'Add Description ...',
                    // text: 'Add description ...',
                    textStyle: interNormalText.copyWith(
                        color: Colors.black87, fontSize: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    hintTextPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    hintTextStyle: const TextStyle(
                        color: newColorLightGrey2,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                    backgroundColor: kContainerFillColor,
                    controller: viewModel.prodDescriptionController,
                    minHeight: Get.height * 0.4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mediaWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Media',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: ThemeHelper.grey2,
                  border: Border.all(
                    color: ThemeHelper.grey1,
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'Choose file',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: ThemeHelper.grey3,
                  border: Border.all(
                    color: ThemeHelper.grey1,
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(8),
                  ),
                ),
                child: const Text('No file chosen'),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget priceField() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Price',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ThemeHelper.grey1),
              ),
            ),
            child: InkWell(
              onTap: () {
                CommonFunction.closeKeyboard();
                viewModel.productPriceUpdate.value = false;
                openPriceBottomSheet();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => viewModel.productPriceUpdate.value == false
                          ? Text(
                              'Rs  0.00',
                              style: GoogleFonts.dmSans(
                                color: newColorLightGrey2,
                              ),
                            )
                          : viewModel.prodCompareAtPriceController.text == ''
                              ? Text(
                                  "Rs  ${viewModel.prodPriceController.text}",
                                  style:
                                      GoogleFonts.dmSans(color: Colors.black),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      viewModel.prodPriceController.text,
                                      style: GoogleFonts.dmSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      viewModel
                                          .prodCompareAtPriceController.text,
                                      style: GoogleFonts.dmSans(
                                          color: Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.red),
                                    )
                                  ],
                                ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff1F2A37),
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future openPriceBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: ThemeHelper.blue1,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Set Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ThemeHelper.blue1,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: ThemeHelper.grey3,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Form(
                    key: viewModel.formPriceField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pricing',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomTextField5(
                          title: 'Price',
                          hintText: 'Rs 0.00',
                          onChanged: (value) {
                            viewModel.prodPriceController.text =
                                (double.parse(value)).toStringAsFixed(2);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null ||
                                value == '' ||
                                double.tryParse(value) == 0.0) {
                              return 'Enter valid price';
                            } else {
                              viewModel.productPriceUpdate.value = true;
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: viewModel.prodPriceController,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 8),
                          child: CustomTextField5(
                            title: 'Compare-at-price',
                            hintText: 'Rs 0.00',
                            onChanged: (value) {
                              viewModel.prodCompareAtPriceController.text =
                                  value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: viewModel.prodCompareAtPriceController,
                          ),
                        ),
                        CustomCheckBox(
                          value: viewModel.chargeTaxOnProduct,
                          onChanged: (value) {
                            viewModel.chargeTaxOnProduct.value = value!;
                          },
                          child: const Text(
                            'Charge tax on this product',
                            style: TextStyle(
                              color: ThemeHelper.grey2,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: CustomTextField5(
                            title: 'Cost per item',
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              viewModel.prodCostPerItemController.text = value;
                              if (double.parse(
                                      viewModel.prodPriceController.text) >=
                                  double.parse(value)) {
                                viewModel.prodProfitController.text =
                                    (double.parse(viewModel
                                                .prodPriceController.text) -
                                            double.parse(value))
                                        .toStringAsFixed(2);
                                double marginAsDouble = (int.parse(value) /
                                    int.parse(
                                        viewModel.prodPriceController.text) *
                                    100);
                                int margin = 100 - marginAsDouble.toInt();
                                viewModel.prodMarginController.text =
                                    "$margin%";
                              } else {
                                return;
                              }
                            },
                            validator: (value) {
                              if (value == '' || value == null) {
                                return null;
                              }
                              if (double.tryParse(value)! >
                                  double.tryParse(
                                      viewModel.prodPriceController.text)!) {
                                viewModel.prodProfitController.clear();
                                return 'Cost per item cannot be greater than Price';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            hintText: 'Rs  0.00',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: viewModel.prodCostPerItemController,
                          ),
                        ),
                        CustomTextField5(
                          title: 'Profit',
                          hintText: '--',
                          controller: viewModel.prodProfitController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField5(
                          title: 'Margin',
                          hintText: '--',
                          controller: viewModel.prodMarginController,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTextBtn(
                  onPressed: () {
                    if (viewModel.formPriceField.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  title: 'Done',
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget typeTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Type',
        controller: viewModel.typeController,
        hintText: 'Select product type',
        isDropDown: true,
        onTap: () {
          CustomBottomSheet2(
            selectedIndex: viewModel.typeSelectedIndex.value,
            typeList: viewModel.typeList,
            onChanged: (value) {
              viewModel.typeSelectedIndex.value = value;
              viewModel.typeController.text = viewModel.typeList[value].name!;
            },
          ).show();
        },
      ),
    );
  }

  Widget categoryTxtField() {
    return CustomTextField1(
      title: 'Category',
      controller: viewModel.categoryController,
      hintText: 'Select product category',
      isDropDown: true,
      onTap: () {
        CustomBottomSheet2(
          selectedIndex: viewModel.categorySelectedIndex.value,
          categoryList: viewModel.categoryList,
          onChanged: (value) {
            viewModel.categorySelectedIndex.value = value;
            viewModel.categoryController.text =
                viewModel.categoryList[value].name!;
          },
        ).show();
      },
    );
  }

  Widget tagsField() {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Tags',
                style: interHeadingSize14,
              ),
            ),
            CustomTextField2(
              focusNode: viewModel.tagsFieldFocusNode,
              onTap: () {
                viewModel.showTagsList.value = true;
              },
              onChanged: (value) {
                if (value == '' || value.isEmpty) {
                  viewModel.searchedTags.clear();
                  for (var element in viewModel.tagsList) {
                    viewModel.searchedTags.add(element);
                  }
                } else {
                  viewModel.searchedTags.clear();
                  for (var element in viewModel.tagsList) {
                    if (element.name!.toLowerCase().contains(value)) {
                      viewModel.searchedTags.add(element);
                      viewModel.searchedTags.refresh();
                    }
                  }
                }
              },
              controller: viewModel.prodTagController,
              prefixIcon: Icons.search,
              hintText: 'Assign tags for this product',
            ),
            tagsDropdown()
          ],
        ));
  }

  Widget thisIsPhysicalProduct() {
    return CustomCheckBox(
      value: viewModel.isPhysicalProduct,
      onChanged: (value) {
        viewModel.isPhysicalProduct.value = value;
      },
      child: const Text(
        'This is physical product.',
        style: TextStyle(
          color: ThemeHelper.grey2,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget tagsDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Stack(
        children: [
          SizedBox(
            height: 30,
            child: Obx(
              () => ListView.builder(
                itemCount: viewModel.chosenTagsList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: newColorLightGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            viewModel.chosenTagsList[index].name!,
                            style: interNormalText.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.chosenTagsList.removeAt(index);
                              viewModel.chosenTagsList.refresh();
                            },
                            child: const Icon(
                              Icons.close,
                              size: 17,
                              color: newColorLightGrey2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            child: Obx(
              () => Visibility(
                visible: viewModel.showTagsList.value,
                child: Container(
                  decoration: textContainerDecoration,
                  height: 120,
                  width: Get.width * 0.8,
                  child: ListView.builder(
                    itemCount: viewModel.searchedTags.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          viewModel.searchedTags[index].isSelected =
                              !viewModel.searchedTags[index].isSelected;
                          viewModel.searchedTags.refresh();
                          if (viewModel.searchedTags[index].isSelected) {
                            viewModel.chosenTagsList
                                .add(viewModel.searchedTags[index]);
                            viewModel.chosenTagsList.refresh();
                          } else {
                            viewModel.chosenTagsList.removeWhere((element) =>
                                element.id == viewModel.searchedTags[index].id);
                            viewModel.chosenTagsList.refresh();
                          }
                        },
                        child: Container(
                          color: viewModel.searchedTags[index].isSelected
                              ? newColorLightGrey
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BottomSheetItem(
                                title: viewModel.searchedTags[index].name!,
                              ),
                              Visibility(
                                visible:
                                    viewModel.searchedTags[index].isSelected,
                                child: const Icon(
                                  Icons.check_rounded,
                                  size: 20,
                                  color: newColorLightGrey2,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _createDynamicFormFields(ProductVariantsModel model) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextFormField(
  //       style: bodyText1,
  //       cursorColor: kPrimaryColor,
  //       keyboardType: TextInputType.text,
  //       onChanged: (value) =>
  //           viewModel.onDynamicFieldsValueChanged(value, model),
  //       decoration: InputDecoration(
  //         labelText: model.label,
  //         labelStyle: bodyText1,
  //         prefixIcon: Icon(
  //           IconlyLight.discovery,
  //           color: kPrimaryColor,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.black,
  //             width: 1,
  //             style: BorderStyle.solid,
  //           ), //B
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.black,
  //             width: 1,
  //             style: BorderStyle.solid,
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _showImages() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: viewModel.productImages.length,
  //     itemBuilder: (context, index) {
  //       File file = viewModel.productImages[index];
  //       return Container(
  //         width: 60,
  //         margin: const EdgeInsets.all(5),
  //         padding: const EdgeInsets.all(8.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         child: Stack(
  //           fit: StackFit.expand,
  //           children: [
  //             Image.file(file),
  //             Positioned(
  //               right: 0,
  //               child: CustomActionIcon(
  //                 width: 25,
  //                 height: 25,
  //                 onTap: () {
  //                   viewModel.imagesSizeInMb.value -=
  //                       (file.lengthSync() * 0.000001);
  //                   viewModel.productImages.removeAt(index);
  //                   if (viewModel.productImages.isEmpty) {
  //                     viewModel.uploadImagesError.value = true;
  //                   }
  //                 },
  //                 hasShadow: false,
  //                 icon: Icons.close_rounded,
  //                 bgColor: ThemeHelper.primary.withOpacity(0.2),
  //                 iconColor: ThemeHelper.primary,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _buildImageSection() {
  //   return GestureDetector(
  //       onTap: () async {
  //         viewModel.productImages.addAll(await PickImage().pickMultipleImage());
  //         if (viewModel.productImages.isNotEmpty) {
  //           viewModel.uploadImagesError.value = false;
  //         }
  //       },
  //       child: Obx(
  //         () => Container(
  //           width: double.infinity,
  //           height: 150,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           child: viewModel.productImages.isNotEmpty
  //               ? _showImages()
  //               : Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     const Icon(
  //                       Icons.cloud_upload_rounded,
  //                       size: 30,
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(
  //                       clickHereToUpload.tr,
  //                       style: const TextStyle(
  //                         color: kLightColor,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //         ),
  //       ));
  // }

// Widget productVariantsAndFeaturesField() {
//   return Obx(
//     () => viewModel.productVariantsFieldsList.isEmpty
//         ? Container()
//         : Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0),
//             child: Column(
//               children: [
//                 CustomText(
//                   title: langKey.productVariant.tr,
//                   style: headline2,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: viewModel.productVariantsFieldsList
//                       .map((variantsModel) {
//                     return Column(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         //displaying the parent one
//                         _singleProductVariantListItem(variantsModel,
//                             icon: CupertinoIcons.add_circled_solid,
//                             onTap: () {
//                           variantsModel.isNewField = true;
//                           variantsModel.moreFieldOptionList!
//                               .add(variantsModel);
//                           viewModel.productVariantsFieldsList.refresh();
//                         }),
//
//                         /// after pressing AddICon more fields would be generated
//                         if (variantsModel.moreFieldOptionList!.isNotEmpty)
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: variantsModel.moreFieldOptionList!
//                                 .map((element) =>
//                                     _singleProductVariantListItem(
//                                         variantsModel,
//                                         icon: CupertinoIcons.clear_circled,
//                                         onTap: () {
//                                       variantsModel.isNewField = false;
//                                       variantsModel.moreFieldOptionList!
//                                           .remove(variantsModel);
//                                       viewModel.productVariantsFieldsList
//                                           .refresh();
//                                     }))
//                                 .toList(),
//                           ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//   );
// }

// Widget _singleProductVariantListItem(ProductVariantsModel model,
//     {onTap, icon}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: Row(
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               _categoryOptionField(model: model),
//               // SizedBox(height: 10),
//               // if (model.categoryFieldOptions!.isNotEmpty)
//               //   Column(
//               //     mainAxisSize: MainAxisSize.min,
//               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //     children: model.categoryFieldOptions!
//               //         .map((element) => _categoryOptionField(
//               //             model: element, icon: Icons.inventory_2_outlined))
//               //         .toList(),
//               //   ),
//             ],
//           ),
//         ),
//         IconButton(
//           onPressed: onTap,
//           icon: Icon(icon),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _categoryOptionField({ProductVariantsModel? model, icon}) {
//   return CustomTextField2(
//     prefixIcon: icon ?? IconlyLight.discovery,
//     keyboardType: TextInputType.text,
//     onChanged: (value) => viewModel.onDynamicFieldsValueChanged(value, model),
//     label: model!.label,
//     autoValidateMode: AutovalidateMode.onUserInteraction,
//     validator: (value) {
//       return Validator().validateDefaultTxtField(value);
//     },
//   );
// }

// Widget stockField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: CustomTextField2(
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//         FilteringTextInputFormatter.digitsOnly
//       ],
//       controller: viewModel.prodStockController,
//       prefixIcon: Icons.inventory_outlined,
//       label: langKey.prodStock.tr,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       // validator: (value) {
//       //   return Validator()
//       //       .validateDefaultTxtField(value, errorPrompt: prodStockReq.tr);
//       // },
//       keyboardType: TextInputType.number,
//     ),
//   );
// }
//
// Widget discountField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: Column(
//       children: [
//         CustomTextField2(
//           controller: viewModel.prodDiscountController,
//           prefixIcon: Icons.discount,
//           label: langKey.prodDiscount.tr,
//           // onChanged: (value) {
//           //   int discount = value.isNotEmpty ? int.parse(value) : 0;
//           //   viewModel.setDiscount(discount);
//           // },
//           keyboardType: TextInputType.number,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//             FilteringTextInputFormatter.digitsOnly
//           ],
//         ),
//         Obx(
//           () => Visibility(
//             visible: viewModel.prodDiscountController.text.isNotEmpty,
//             child: CustomText(
//               title: viewModel.discountMessage.value,
//               color: kRedColor,
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// Widget weightAndDimensionsSection() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 30.0),
//     child: Column(
//       children: [
//         CustomText(
//           title: langKey.weightAndDimension.tr,
//           style: headline2,
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         weightField(),
//         lengthField(),
//         widthField(),
//         heightField()
//       ],
//     ),
//   );
// }
//
// Widget weightField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: CustomTextField2(
//       controller: viewModel.prodWeightController,
//       label: langKey.weight.tr,
//       prefixIcon: Icons.scale_outlined,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       // validator: (value) {
//       //   return Validator().validateWeightField(value!);
//       // },
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//       ],
//     ),
//   );
// }
//
// Widget lengthField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: CustomTextField2(
//       controller: viewModel.prodLengthController,
//       label: langKey.length.tr,
//       prefixIcon: Icons.numbers,
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//       ],
//     ),
//   );
// }
//
// Widget widthField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: CustomTextField2(
//       controller: viewModel.prodWidthController,
//       label: langKey.width.tr,
//       prefixIcon: Icons.numbers,
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//       ],
//     ),
//   );
// }
//
// Widget heightField() {
//   return Padding(
//     padding: const EdgeInsets.only(top: 12.0),
//     child: CustomTextField2(
//       controller: viewModel.prodHeightController,
//       label: langKey.height.tr,
//       prefixIcon: Icons.numbers,
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//       ],
//     ),
//   );
// }
}
