import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/widgets/custom_dropdown.dart';
import 'package:ismmart_vms/widgets/widget_models/variant_options_field_model.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../../../helper/constants.dart';
import '../../../helper/theme_helper.dart';
import '../../../widgets/bottomsheet_item.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/pick_image.dart';
import 'add_product_1_viewmodel.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart' as langKey;

class AddProductView extends StatelessWidget {
  AddProductView({super.key});
  final AddProductViewModel viewModel = Get.put(AddProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Add Product'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Colors.black,
              ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    stepperText(),
                    Form(
                      key: viewModel.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            titleField(),
                            priceField(),
                            // stockField(),
                            // discountField(),
                            // descriptionField(),
                            // weightAndDimensionsSection(),
                            // variantAdditionField(context),
                            // Obx(() => viewModel.showVariantsTable.value ? variantsTable() : const SizedBox()),
                            // productVariantsAndFeaturesField(),
                            const SizedBox(height: 40),
                            // CustomTextBtn(
                            //   onPressed: () {
                            //     viewModel.creatingVariants();
                            //     viewModel.addProdBtnPress();
                              // },
                              // title: 'Add Product',
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepperText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Product Info',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
            ),
            TextSpan(
              text: '  /  ',
              style: TextStyle(
                color: kLightColor,
                fontSize: 14,
                fontWeight: FontWeight.w300
              )
            ),
            TextSpan(
              text: 'Pricing and Shipping',
              style: TextStyle(
                  color: kLightColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300
              )
            ),
            TextSpan(
                text: '  /  ',
                style: TextStyle(
                    color: kLightColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                )
            ),
            TextSpan(
                text: 'Variants',
                style: TextStyle(
                    color: kLightColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                )
            ),
          ]
        ),
      ),
    );
  }

  Widget titleField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        title: langKey.productTitle.tr,
        hintText: langKey.productName.tr,
        controller: viewModel.prodTitleController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator()
        //       .validateName(value, errorToPrompt: langKey.productNameReq.tr);
        // },
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget descriptionField() {
    return SizedBox(
      child: Column(
        children: [
          ToolBar(
            // toolBarConfig: viewModel.customToolBarList,
              controller: viewModel.prodDescriptionController,
            toolBarColor: kDescriptionToolbarColor,
            iconColor: const Color(0xff929AAB),
          ),
          QuillHtmlEditor(
            hintText: 'Enter Text',
            hintTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
            backgroundColor: kContainerFillColor,
              controller: viewModel.prodDescriptionController,
              minHeight: Get.height * 0.5
          ),
        ],
      ),
    );
  }

  Widget variantAdditionField(BuildContext context) {
    return Obx(() =>
    viewModel.showVariantsField.value ? Column(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: viewModel.listOfOptionsAdded.length,
            itemBuilder: (context, index) {
              TextEditingController optionName = TextEditingController();
              optionName.text = viewModel.listOfOptionsAdded[index].optionName!;
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CustomTextField2(
                          enabled: optionName.text == '' ? true : false,
                          title: 'Option Name',
                          controller: optionName,
                          onChanged: (value) {
                            viewModel.finalCombinationsList[index].variantName = value;
                            viewModel.finalCombinationsList.refresh();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: IconButton(
                            onPressed: () {
                              viewModel.listOfOptionsAdded.removeAt(index);
                              viewModel.listOfOptionsAdded.refresh();
                            },
                            icon: const Icon(
                              Icons.delete_outline_rounded, size: 30,
                              color: Colors.red,
                            ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(thickness: 0.8, color: kLightColor,),
                  ),
                  Obx(() =>
                      ListView.builder(
                        physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.listOfOptionsAdded[index].optionValues?.length,
                          itemBuilder: (context, optionIndex) {
                            TextEditingController optionController = viewModel.listOfOptionsAdded[index].optionValues![optionIndex];
                            String? title;
                            if(optionController == viewModel.listOfOptionsAdded[index].optionValues?.first){
                              title = 'Option Values';
                            }
                            if (optionIndex == viewModel.listOfOptionsAdded[index].optionValues!.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: CustomTextField2(
                                        title: title,
                                        onChanged: (value) {
                                          optionController.text = value;
                                        },
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.black,
                                      child: InkWell(
                                        onTap: () {
                                          if (optionController.text == "" ||
                                              optionController.text
                                                  .isEmpty) {
                                            AppConstant.displaySnackBar('Error',
                                                'Enter Value to add more fields');
                                          } else {
                                            viewModel.listOfOptionsAdded[index].optionValues?.add(
                                                TextEditingController());
                                            viewModel.listOfOptionsAdded.refresh();
                                          }
                                        },
                                        child: const Icon(Icons.add, size: 20,
                                          color: Colors.white,),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: CustomTextField2(
                                        onChanged: (value) {
                                          optionController.text = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: IconButton(
                                          onPressed: () {
                                            viewModel.listOfOptionsAdded[index].optionValues?.removeAt(optionIndex);
                                            viewModel.listOfOptionsAdded.refresh();
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            size: 30, color: Colors.red,
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                      ),
                  ),
                  Obx(() =>  index == viewModel.listOfOptionsAdded.length-1 ? const SizedBox() : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(thickness: 1.3, color: Colors.black,),
                  ),
              ),
                ],
              );
            }
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                await variantSelectionDialog();
                viewModel.showVariantsField.value = true;
              },
              child: const Align(
                alignment: Alignment.centerLeft, child: Text('Add another Option'),
              ),
            ),
            TextButton(
              onPressed: () async {
                await viewModel.creatingVariants();
                viewModel.locationSelected.value = viewModel.locationsList[0].id!;
                // print(viewModel.locationSelected.value);
                viewModel.showVariantsTable.value = true;
                viewModel.showVariantsField.value = false;
                // await variantSelectionDialog();
                // viewModel.showVariantsField.value = true;
              },
              child: const Align(
                alignment: Alignment.centerRight, child: Text('Done'),
              ),
            ),
          ],
        ),
      ],
    ) : TextButton(
        onPressed: () async {
          await variantSelectionDialog();
          viewModel.showVariantsField.value = true;
        },
        child: const Align(
            alignment: Alignment.centerLeft, child: Text('Add Variants'))));
  }

  Widget variantsTable() {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          CustomDropDownList1(
              value: viewModel.locationSelected,
              onChanged: (value) {
                viewModel.locationSelected.value = value;
              },
              list: viewModel.locationsList
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: (){},
                icon: const Icon(
                    Icons.more_horiz_rounded,
                  size: 20,
                  color: Colors.black,
                )
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: viewModel.finalCombinationsList.length,
            itemBuilder: (context, index){
              return Row(
                children: [
                  Checkbox(
                      value: viewModel.finalCombinationsList[index].variantSelected,
                      onChanged: (value) {
                        viewModel.finalCombinationsList[index].variantSelected = value;
                        viewModel.finalCombinationsList.refresh();
                      },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    viewModel.finalCombinationsList[index].variantName!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400
                    ),
                  ),

                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  Future variantSelectionDialog() {
    return showModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Choose Option',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.optionsList.length,
                  itemBuilder: (context, index) {
                    return BottomSheetItem(
                        title: viewModel.optionsList[index],
                      onTap: () {
                          if(viewModel.optionsChosen.contains(viewModel.optionsList[index])){
                            AppConstant.displaySnackBar('Error', 'Option Already Selected');
                          } else {
                            if (viewModel.optionsList[index] == 'Other') {
                              viewModel.listOfOptionsAdded.add(
                                VariantsOptionsFieldModel(
                                  optionName: '',
                                  optionValues: <TextEditingController>[TextEditingController()]
                                )
                              );
                              viewModel.listOfOptionsAdded.refresh();
                              Navigator.pop(context);
                            } else {
                              viewModel.selectedOption.value =
                              viewModel.optionsList[index];
                              viewModel.listOfOptionsAdded.add(
                                VariantsOptionsFieldModel(
                                    optionName: viewModel.optionsList[index],
                                    optionValues: <TextEditingController>[
                                      TextEditingController()
                                    ]
                                ),
                              );
                              viewModel.optionsChosen.add(viewModel.optionsList[index]);
                              viewModel.listOfOptionsAdded.refresh();
                              viewModel.optionsChosen.refresh();
                              Navigator.pop(context);
                            }
                          }
                      },
                    );
                },
                )
              ],
            ),
          );
        }
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

  Widget _showImages() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.productImages.length,
      itemBuilder: (BuildContext, index) {
        File file = viewModel.productImages[index];
        return Container(
          width: 60,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file),
              Positioned(
                right: 0,
                child: CustomActionIcon(
                  width: 25,
                  height: 25,
                  onTap: () {
                    viewModel.imagesSizeInMb.value -=
                        (file.lengthSync() * 0.000001);
                    viewModel.productImages.removeAt(index);
                    if (viewModel.productImages.isEmpty) {
                      viewModel.uploadImagesError.value = true;
                    }
                  },
                  hasShadow: false,
                  icon: Icons.close_rounded,
                  bgColor: ThemeHelper.primary.withOpacity(0.2),
                  iconColor: ThemeHelper.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
        onTap: () async {
          viewModel.productImages.addAll(await PickImage().pickMultipleImage());
          if (viewModel.productImages.isNotEmpty) {
            viewModel.uploadImagesError.value = false;
          }
        },
        child: Obx(() =>
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: viewModel.productImages.isNotEmpty
                  ? _showImages()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_rounded,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    langKey.clickHereToUpload.tr,
                    style: const TextStyle(
                      color: kLightColor,
                    ),
                  )
                ],
              ),
            ),
        )
    );
  }

  Widget priceField() {
    return Padding(
      padding: EdgeInsets.only(top: viewModel.fieldsPaddingSpace),
      child: Column(
        children: [
          CustomTextField2(
            readOnly: true,
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: Get.context!,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Set Price',
                                    style: GoogleFonts.lato(
                                      color: newColorBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                            // const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                decoration: const BoxDecoration(
                                  color: kContainerFillColor,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pricing',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(height: 8,),
                                    CustomTextField2(
                                      title: 'Price',
                                      titleColor: newColorLightGrey2,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      hintText: 'Rs  0.00',
                                      controller: viewModel.prodPriceController,
                                    ),
                                    CustomTextField2(
                                      title: 'Compare-at-price',
                                      titleColor: newColorLightGrey2,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      hintText: 'Rs  0.00',
                                      controller: viewModel.prodCostPerItemController,
                                    ),
                                    Row(
                                      children: [
                                        Obx(() => Checkbox(
                                            side: const BorderSide(
                                                color: Colors.blue
                                            ),
                                            fillColor: viewModel.chargeTaxOnProduct.value ? MaterialStateColor.resolveWith((states) => Colors.blue) : MaterialStateColor.resolveWith((states) => Colors.white),
                                            checkColor: Colors.white,
                                            value: viewModel.chargeTaxOnProduct.value,
                                            onChanged: (value) {
                                              viewModel.chargeTaxOnProduct.value = value!;
                                            }
                                        ),
                                        ),
                                        Text(
                                          'Charge tax on this product',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400
                                          ),
                                        )
                                      ],
                                    ),
                                    CustomTextField2(
                                      title: 'Cost per item',
                                      titleColor: newColorLightGrey2,
                                      autoValidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if(value == '' || value == null) {
                                          return null;
                                        }
                                        if(double.tryParse(value)! > double.tryParse(viewModel.prodPriceController.text)!){
                                          viewModel.prodProfitController.clear();
                                          return 'Cost per item cannot be greater than Price';
                                        } else {
                                          return null;
                                        }
                                      },
                                      hintText: 'Rs  0.00',
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: viewModel.prodCostPerItemController,
                                    ),
                                    CustomTextField2(
                                      title: 'Profit',
                                      hintText: '--',
                                      titleColor: newColorLightGrey2,
                                      controller: viewModel.prodProfitController,
                                      enabled: false,
                                    ),
                                    CustomTextField2(
                                      title: 'Margin',
                                      hintText: '--',
                                      titleColor: newColorLightGrey2,
                                      controller: viewModel.prodMarginController,
                                      enabled: false,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            hintText: 'Rs  0.00',
            suffixIcon: IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 18,
              ),
              ),
            // enabled: false,
            controller: viewModel.prodPriceController,
            title: langKey.prodPrice.tr,
            // autoValidateMode: AutovalidateMode.onUserInteraction,
            // validator: (value) {
            //   return Validator().validateDefaultTxtField(value,
            //       errorPrompt: langKey.prodPriceReq.tr);
            // },
            // onChanged: (value) {
            //   viewModel.onPriceFieldChange(value);
            // },
            keyboardType: TextInputType.number,
          ),
          // Obx(
          //   () => Visibility(
          //     visible: viewModel.prodPriceController.text.isNotEmpty,
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 4.0),
          //       // child: CustomText(
          //       //   title:
          //       //       "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
          //       //   color: kRedColor,
          //       // ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

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

  Widget stockField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: viewModel.prodStockController,
        prefixIcon: Icons.inventory_outlined,
        label: langKey.prodStock.tr,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator()
        //       .validateDefaultTxtField(value, errorPrompt: prodStockReq.tr);
        // },
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget discountField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          CustomTextField2(
            controller: viewModel.prodDiscountController,
            prefixIcon: Icons.discount,
            label: langKey.prodDiscount.tr,
            // onChanged: (value) {
            //   int discount = value.isNotEmpty ? int.parse(value) : 0;
            //   viewModel.setDiscount(discount);
            // },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          Obx(
            () => Visibility(
              visible: viewModel.prodDiscountController.text.isNotEmpty,
              child: CustomText(
                title: viewModel.discountMessage.value,
                color: kRedColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget weightAndDimensionsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          CustomText(
            title: langKey.weightAndDimension.tr,
            style: headline2,
          ),
          const SizedBox(
            height: 15,
          ),
          weightField(),
          lengthField(),
          widthField(),
          heightField()
        ],
      ),
    );
  }

  Widget weightField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodWeightController,
        label: langKey.weight.tr,
        prefixIcon: Icons.scale_outlined,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateWeightField(value!);
        // },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget lengthField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodLengthController,
        label: langKey.length.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget widthField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodWidthController,
        label: langKey.width.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget heightField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodHeightController,
        label: langKey.height.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }
}