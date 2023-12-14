import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/widgets/widget_models/variant_options_field_model.dart';
import '../../helper/constants.dart';
import '../../helper/theme_helper.dart';
import '../../widgets/bottomsheet_item.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/pick_image.dart';
import 'add_product_viewmodel.dart';
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
              child: Column(
                children: [
                  Form(
                    key: viewModel.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Upload Images Section
                          _buildImageSection(),

                          ///Product Category Field
                          // Obx(() => selectCategoryField()),
                          //
                          // ///Product Sub Category Dropdown Field
                          // Obx(() => viewModel.subCategoriesList.isEmpty
                          //     ? Container()
                          //     : selectSubCategoryField()),

                          ///Product Category fields or variants or features

                          ///Product Basic Details
                          nameField(),
                          priceField(),
                          stockField(),
                          discountField(),
                          descriptionField(),
                          weightAndDimensionsSection(),
                          variantAdditionField(context),
                          // productVariantsAndFeaturesField(),
                          const SizedBox(height: 40),
                          CustomTextBtn(
                            onPressed: () {
                              viewModel.creatingVariants();
                              // viewModel.addProdBtnPress();
                            },
                            title: 'Add Product',
                          ),
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

  Widget variantAdditionField(BuildContext context) {
    return Obx(() =>
    viewModel.showVariantsField.value ? Column(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
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
                          enabled: false,
                          title: 'Option Name',
                          controller: optionName,
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: IconButton(
                            onPressed: () {
                              viewModel.listOfOptionsAdded.removeAt(index);
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
                          if(viewModel.listOfOptionsAdded.contains(viewModel.optionsList[index])){
                            AppConstant.displaySnackBar('Error', 'Option Already Selected');
                          } else {
                            viewModel.selectedOption.value =
                            viewModel.optionsList[index];
                            viewModel.listOfOptionsAdded.add(
                                VariantsOptionsFieldModel(
                                    optionName: viewModel.optionsList[index],
                                  optionValues: <TextEditingController>[TextEditingController()]
                                ),
                            );
                            viewModel.listOfOptionsAdded.refresh();
                            Navigator.pop(context);
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

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField3(
        title: 'Name',
        controller: viewModel.prodNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator()
        //       .validateName(value, errorToPrompt: langKey.productNameReq.tr);
        // },
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget priceField() {
    return Padding(
      padding: EdgeInsets.only(top: viewModel.fieldsPaddingSpace),
      child: Column(
        children: [
          CustomTextField3(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: viewModel.prodPriceController,
            title: langKey.prodPrice.tr,
            autoValidateMode: AutovalidateMode.onUserInteraction,
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

  Widget descriptionField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodDescriptionController,
        label: langKey.description.tr,
        prefixIcon: Icons.description_outlined,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return Validator().validateDefaultTxtField(value,
        //       errorPrompt: langKey.descriptionReq.tr);
        // },
        keyboardType: TextInputType.text,
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