import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
import 'package:ismmart_vms/widgets/custom_appbar.dart';
import 'package:ismmart_vms/widgets/custom_bottom_sheet2.dart';
import 'package:ismmart_vms/widgets/pick_image.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../../../helper/constants.dart';
import '../../../helper/theme_helper.dart';
import '../../../helper/validator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/stepperText.dart';
import 'add_product_1_viewmodel.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;

class AddProduct1View extends StatelessWidget {
  AddProduct1View({super.key});

  final AddProduct1ViewModel viewModel = Get.put(AddProduct1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVariable.selectedIndex.value == 2 ? null : appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            stepperText(1),
            Form(
              key: viewModel.productDetailsFormKey,
              child: Column(
                children: [
                  titleTxtField(),
                  descriptionField(),
                  mediaWidget(),
                  typeTxtField(),
                  categoryTxtField(),
                  // tagsField(),
                  const SizedBox(height: 15,),
                  CustomTextBtn(
                    onPressed: () {
                      viewModel.proceed();
                    },
                    title: 'Save & Continue',
                  ),
                  CustomTextBtn(
                    title: 'Back',
                    backgroundColor: Colors.black,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: newColorLightGrey2,
          )),
      title: Text(
        'Add Product',
        style: dmSerifDisplay1.copyWith(fontSize: 20),
      ),
      centerTitle: true,
    );
  }

  Widget titleTxtField() {
    return CustomTextField1(
      title: 'Title',
      hintText: 'Product Name',
      controller: viewModel.prodTitleController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator()
            .validateName(value, errorToPrompt: langKey.productNameReq.tr);
      },
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
        Obx(() => Container(
          padding: viewModel.productImagesList.isEmpty ? null : const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: viewModel.productImagesUploadCheck.value || viewModel.imagesThumbnailCheck.value ? Colors.red.shade700 : ThemeHelper.grey1,
              width: 1,
            ),
          ),
          child: viewModel.productImagesList.isEmpty ? Row(
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
                    child: InkWell(
                      onTap: () async {
                        final images = await PickImage().pickMultipleImage();
                        if(images.isNotEmpty) {
                          viewModel.imagesThumbnailCheck.value = false;
                          viewModel.productImagesUploadCheck.value = false;
                        for (var element in images) {
                          final splitted = element.path.split('/');
                          if (viewModel.productImagesList.isEmpty) {
                            viewModel.productImagesList.add(
                                PicturesModel(
                                  fileName: splitted.last,
                                  filePath: element.path,
                                  isThumbnail: true,
                                )
                            );
                            viewModel.productImagesList.refresh();
                          } else {
                            viewModel.productImagesList.add(
                                PicturesModel(
                                  fileName: splitted.last,
                                  filePath: element.path,
                                  isThumbnail: false,
                                )
                            );
                            viewModel.productImagesList.refresh();
                          }
                        }
                        }
                      },
                      child: const Text(
                        'Choose file',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          decorationColor: Colors.white,
                        ),
                      ),
                    )
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
              ]
            ) : Column(
              children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Remove',
                          style: interNormalText.copyWith(
                              color: newColorLightGrey2,
                              fontSize: 11,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Thumbnail',
                          style: interNormalText.copyWith(
                              color: newColorLightGrey2,
                              fontSize: 11,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                      'Filename',
                      style: interNormalText.copyWith(
                          color: newColorLightGrey2,
                          fontWeight: FontWeight.w600,
                          fontSize: 11
                      )
                  ),
                ),
              )
            ],
          ),
                const SizedBox(height: 8,),
                Column (
                children: List.generate(
                    viewModel.productImagesList.length,
                        (idx) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              viewModel.productImagesList.removeAt(idx);
                                              viewModel.productImagesList.refresh();
                                            },
                                            enableFeedback: false,
                                            child: const Icon(
                                              Icons.delete_outline_rounded,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        Expanded(
                                          child: InkWell(
                                            enableFeedback: false,
                                            onTap: () {
                                              viewModel.imagesThumbnailCheck.value = false;
                                              for (var element in viewModel.productImagesList) {
                                                element.isThumbnail = false;
                                              }
                                              viewModel.productImagesList[idx].isThumbnail = !viewModel.productImagesList[idx].isThumbnail!;
                                              viewModel.productImagesList.refresh();
                                            },
                                            child: AnimatedContainer(
                                              height: 17,
                                              width: 17,
                                              decoration: BoxDecoration(
                                                  color: viewModel.productImagesList[idx].isThumbnail! ? newColorBlue : Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: viewModel.productImagesList[idx].isThumbnail! ? newColorBlue : newColorLightGrey3,
                                                      width: 0.8
                                                  )
                                              ),
                                              duration: const Duration(milliseconds: 200),
                                              child: viewModel.productImagesList[idx].isThumbnail! ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 14,
                                              ) : const SizedBox(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        viewModel.productImagesList[idx].fileName!,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            decoration: TextDecoration.underline,
                                            fontSize: 11,
                                            decorationColor: Colors.red,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              idx == viewModel.productImagesList.length - 1 ? InkWell(
                                onTap: () async {
                                  final images = await PickImage().pickMultipleImage();
                                  for (var element in images) {
                                    int index = viewModel.productImagesList.indexWhere((element1) => element1.filePath == element.path);
                                    if(index == -1){
                                      final splitted = element.path.split("/");
                                      viewModel.productImagesList.add(PicturesModel(
                                          filePath: element.path,
                                          fileName: splitted.last,
                                          isThumbnail: false
                                      ));
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    color: newColorLightGrey3,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add_rounded, size: 18, color: Colors.white,),
                                ),
                              ) : const Divider(thickness: 1.2, color: newColorLightGrey2,)
                            ],
                          ),
                        );
                      }
                ),
                          ),
              ],
            ),
        ),
        ),
        Obx(() => viewModel.imagesThumbnailCheck.value ? Text(
          'Set one image as thumbnail',
          style: interNormalText.copyWith(
            color: Colors.red.shade700,
            fontSize: 12
          ),
        ) : viewModel.productImagesUploadCheck.value ? Text(
          'Upload product image(s) to proceed',
          style: interNormalText.copyWith(
              color: Colors.red.shade700,
              fontSize: 12
          ),
        ) : const SizedBox(),
        )
      ],
    );
  }

  // Widget priceField() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 18),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         const Text(
  //           'Price',
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.only(top: 8),
  //           decoration: const BoxDecoration(
  //             border: Border(
  //               bottom: BorderSide(color: ThemeHelper.grey1),
  //             ),
  //           ),
  //           child: InkWell(
  //             onTap: () {
  //               CommonFunction.closeKeyboard();
  //               viewModel.productPriceUpdate.value = false;
  //               openPriceBottomSheet();
  //             },
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Obx(
  //                     () => viewModel.productPriceUpdate.value == false
  //                         ? Text(
  //                             'Rs  0.00',
  //                             style: GoogleFonts.dmSans(
  //                               color: newColorLightGrey2,
  //                             ),
  //                           )
  //                         : viewModel.prodCompareAtPriceController.text == ''
  //                             ? Text(
  //                                 "Rs  ${viewModel.prodPriceController.text}",
  //                                 style:
  //                                     GoogleFonts.dmSans(color: Colors.black),
  //                               )
  //                             : Column(
  //                                 children: [
  //                                   Text(
  //                                     viewModel.prodPriceController.text,
  //                                     style: GoogleFonts.dmSans(
  //                                         color: Colors.black,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                   const SizedBox(height: 5),
  //                                   Text(
  //                                     viewModel
  //                                         .prodCompareAtPriceController.text,
  //                                     style: GoogleFonts.dmSans(
  //                                         color: Colors.red,
  //                                         fontSize: 10,
  //                                         fontWeight: FontWeight.w400,
  //                                         decoration:
  //                                             TextDecoration.lineThrough,
  //                                         decorationColor: Colors.red),
  //                                   )
  //                                 ],
  //                               ),
  //                   ),
  //                   const Icon(
  //                     Icons.arrow_forward_ios_rounded,
  //                     color: Color(0xff1F2A37),
  //                     size: 16,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future openPriceBottomSheet() {
  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: MediaQuery.of(context).viewInsets,
  //         child: SingleChildScrollView(
  //           padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
  //           child: Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   const Icon(
  //                     Icons.menu,
  //                     color: ThemeHelper.blue1,
  //                   ),
  //                   const SizedBox(width: 10),
  //                   const Text(
  //                     'Set Price',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       color: ThemeHelper.blue1,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   IconButton(
  //                     onPressed: () {
  //                       Get.back();
  //                     },
  //                     icon: const Icon(
  //                       Icons.close,
  //                       color: Colors.red,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.only(top: 10, bottom: 10),
  //                 padding:
  //                     const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
  //                 decoration: const BoxDecoration(
  //                   color: ThemeHelper.grey3,
  //                   borderRadius: BorderRadius.all(Radius.circular(8)),
  //                 ),
  //                 child: Form(
  //                   key: viewModel.formPriceField,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const Text(
  //                         'Pricing',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 15),
  //                       CustomTextField5(
  //                         title: 'Price',
  //                         hintText: 'Rs 0.00',
  //                         onChanged: (value) {
  //                           viewModel.prodPriceController.text =
  //                               (double.parse(value)).toStringAsFixed(2);
  //                         },
  //                         inputFormatters: [
  //                           FilteringTextInputFormatter.allow(
  //                               RegExp(r'[0-9.]')),
  //                           FilteringTextInputFormatter.digitsOnly
  //                         ],
  //                         validator: (value) {
  //                           if (value == null ||
  //                               value == '' ||
  //                               double.tryParse(value) == 0.0) {
  //                             return 'Enter valid price';
  //                           } else {
  //                             viewModel.productPriceUpdate.value = true;
  //                             return null;
  //                           }
  //                         },
  //                         keyboardType: TextInputType.number,
  //                         controller: viewModel.prodPriceController,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 10, bottom: 8),
  //                         child: CustomTextField5(
  //                           title: 'Compare-at-price',
  //                           hintText: 'Rs 0.00',
  //                           onChanged: (value) {
  //                             viewModel.prodCompareAtPriceController.text =
  //                                 value;
  //                           },
  //                           inputFormatters: [
  //                             FilteringTextInputFormatter.allow(
  //                                 RegExp(r'[0-9.]')),
  //                             FilteringTextInputFormatter.digitsOnly
  //                           ],
  //                           keyboardType: TextInputType.number,
  //                           controller: viewModel.prodCompareAtPriceController,
  //                         ),
  //                       ),
  //                       CustomCheckBox(
  //                         value: viewModel.chargeTaxOnProduct,
  //                         onChanged: (value) {
  //                           viewModel.chargeTaxOnProduct.value = value!;
  //                         },
  //                         child: const Text(
  //                           'Charge tax on this product',
  //                           style: TextStyle(
  //                             color: ThemeHelper.grey2,
  //                             fontSize: 10,
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 10, bottom: 10),
  //                         child: CustomTextField5(
  //                           title: 'Cost per item',
  //                           autoValidateMode:
  //                               AutovalidateMode.onUserInteraction,
  //                           onChanged: (value) {
  //                             viewModel.prodCostPerItemController.text = value;
  //                             if (double.parse(
  //                                     viewModel.prodPriceController.text) >=
  //                                 double.parse(value)) {
  //                               viewModel.prodProfitController.text =
  //                                   (double.parse(viewModel
  //                                               .prodPriceController.text) -
  //                                           double.parse(value))
  //                                       .toStringAsFixed(2);
  //                               double marginAsDouble = (int.parse(value) /
  //                                   int.parse(
  //                                       viewModel.prodPriceController.text) *
  //                                   100);
  //                               int margin = 100 - marginAsDouble.toInt();
  //                               viewModel.prodMarginController.text =
  //                                   "$margin%";
  //                             } else {
  //                               return;
  //                             }
  //                           },
  //                           validator: (value) {
  //                             if (value == '' || value == null) {
  //                               return null;
  //                             }
  //                             if (double.tryParse(value)! >
  //                                 double.tryParse(
  //                                     viewModel.prodPriceController.text)!) {
  //                               viewModel.prodProfitController.clear();
  //                               return 'Cost per item cannot be greater than Price';
  //                             } else {
  //                               return null;
  //                             }
  //                           },
  //                           keyboardType: TextInputType.number,
  //                           hintText: 'Rs  0.00',
  //                           inputFormatters: [
  //                             FilteringTextInputFormatter.allow(
  //                                 RegExp(r'[0-9.]')),
  //                             FilteringTextInputFormatter.digitsOnly
  //                           ],
  //                           controller: viewModel.prodCostPerItemController,
  //                         ),
  //                       ),
  //                       CustomTextField5(
  //                         title: 'Profit',
  //                         hintText: '--',
  //                         controller: viewModel.prodProfitController,
  //                         readOnly: true,
  //                       ),
  //                       const SizedBox(height: 10),
  //                       CustomTextField5(
  //                         title: 'Margin',
  //                         hintText: '--',
  //                         controller: viewModel.prodMarginController,
  //                         readOnly: true,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               CustomTextBtn(
  //                 onPressed: () {
  //                   if (viewModel.formPriceField.currentState!.validate()) {
  //                     Get.back();
  //                   }
  //                 },
  //                 title: 'Done',
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget typeTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Type',
        validator: (value) {
          if(value == null || value == '' || value.isEmpty) {
            return 'Product Type is required';
          } else {
            return null;
          }
        },
        controller: viewModel.typeController,
        hintText: 'Select product type',
        isDropDown: true,
        onTap: () {
          CustomBottomSheet2(
            selectedIndex: viewModel.typeSelectedIndex.value,
            itemsList: viewModel.typeList,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField1(
          title: 'Category',
          hintText: 'Select one or more product category',
          isDropDown: true,
          validator: (value) {
            if(viewModel.chosenCategoriesList.isEmpty) {
              return 'Choose product category';
            } else {
              return null;
            }
          },
          onTap: () {
            CustomBottomSheet2(
              selectedIndex: viewModel.selectedCategory.value,
              itemsList: viewModel.productCategoryList,
              onChanged: (value) {
                viewModel.chosenCategoriesList.add(viewModel.productCategoryList[value]);
                viewModel.chosenCategoriesList.last.oldIndex = value;
                viewModel.productCategoryList.removeAt(value);
              },
            ).show();
          },
        ),
        const SizedBox(height: 5,),
        Obx(() => Wrap(
            children: List.generate(
                viewModel.chosenCategoriesList.length,
                    (index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(4),
                    height: 30,
                    decoration: BoxDecoration(
                      color: newColorLightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          viewModel.chosenCategoriesList[index].name!,
                          style: interNormalText.copyWith(
                              fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(width: 4,),
                        InkWell(
                          onTap: () {
                            viewModel.productCategoryList.insert(viewModel.chosenCategoriesList[index].oldIndex!, viewModel.chosenCategoriesList[index]);
                            viewModel.chosenCategoriesList.removeAt(index);
                            viewModel.chosenCategoriesList.refresh();
                          },
                          child: const Icon(
                            Icons.close,
                            size: 15,
                            color: newColorLightGrey3,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget tagsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField1(
          title: 'Tags',
          hintText: 'Assign tags for this product',
          isDropDown: true,
          onTap: () {
            CustomBottomSheet2(
              selectedIndex: viewModel.selectedCategory.value,
              itemsList: viewModel.tagsList,
              onChanged: (value) {
                viewModel.chosenTagsList.add(viewModel.tagsList[value]);
                viewModel.chosenTagsList.last.oldIndex = value;
                viewModel.tagsList.removeAt(value);
              },
            ).show();
          },
        ),
        const SizedBox(height: 5,),
        Obx(() => Wrap(
          children: List.generate(
              viewModel.chosenTagsList.length,
                  (index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(4),
                  height: 30,
                  decoration: BoxDecoration(
                    color: newColorLightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        viewModel.chosenTagsList[index].name!,
                        style: interNormalText.copyWith(
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(width: 4,),
                      InkWell(
                        onTap: () {
                          viewModel.tagsList.insert(viewModel.chosenTagsList[index].oldIndex!, viewModel.chosenTagsList[index]);
                          viewModel.chosenTagsList.removeAt(index);
                          viewModel.chosenTagsList.refresh();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 15,
                          color: newColorLightGrey3,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        )
      ],
    );
  }
}