import 'dart:io';
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
              physics: ScrollPhysics(),
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
                            descriptionField(),
                            priceField(),
                            typeField(),
                            categoryField(),
                            tagsField(),
                            // tagsDropdown(),
                            // stockField(),
                            // discountField(),
                            // weightAndDimensionsSection(),
                            // variantAdditionField(context),
                            // Obx(() => viewModel.showVariantsTable.value ? variantsTable() : const SizedBox()),
                            // productVariantsAndFeaturesField(),
                            // const SizedBox(height: 40),
                            CustomTextBtn(
                              onPressed: () {
                                // viewModel.creatingVariants();
                                // viewModel.addProdBtnPress();
                              },
                              title: 'Save & Continue',
                            ),
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
                color: newColorBlue,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Description',
              style: dmSansHeading
            ),
          ),
          ToolBar(
            toolBarConfig: viewModel.customToolBarList,
              controller: viewModel.prodDescriptionController,
            toolBarColor: kDescriptionToolbarColor,
            iconColor: const Color(0xff929AAB),
          ),
          QuillHtmlEditor(
            hintText: 'Enter Text',
            hintTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
            backgroundColor: kContainerFillColor,
              controller: viewModel.prodDescriptionController,
              minHeight: Get.height * 0.4
          ),
        ],
      ),
    );
  }

  Widget priceField() {
    return Padding(
      padding: EdgeInsets.only(top: viewModel.fieldsPaddingSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Price',
            style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.normal
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            decoration: textContainerDecoration.copyWith(
              boxShadow: const [
                BoxShadow(
                    color: kLightGreyColor,
                    offset: Offset(0, 1),
                    spreadRadius: 0.5,
                    blurRadius: 1
                )
              ],
            ),
            child: InkWell(
              onTap: () {
                viewModel.productPriceUpdate.value = false;
                openPriceBottomSheet();
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => viewModel.productPriceUpdate.value == false ? Text(
                        'Rs  0.00',
                        style: GoogleFonts.dmSans(
                          color: newColorLightGrey2,
                        ),
                      ) : viewModel.prodCompareAtPriceController.text == '' ? Text(
                        "Rs  ${viewModel.prodPriceController.text}",
                        style: GoogleFonts.dmSans(
                            color: Colors.black
                        ),
                      ) : Column(
                        children: [
                          Text(
                            viewModel.prodPriceController.text,
                            style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            viewModel.prodCompareAtPriceController.text,
                            style: GoogleFonts.dmSans(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red
                            ),
                          )
                        ],
                      ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 18,
                      )
                    ],
                  )
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
        context: Get.context!,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
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
                          child: Form(
                            key: viewModel.formPriceField,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Pricing',
                                    style: GoogleFonts.dmSans(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    )
                                ),
                                const SizedBox(height: 8,),
                                CustomTextField2(
                                  title: 'Price',
                                  titleColor: newColorLightGrey2,
                                  onChanged: (value) {
                                    viewModel.prodPriceController.text = (double.parse(value)).toStringAsFixed(2);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if(value == null || value == '' || double.tryParse(value) == 0.0) {
                                      return 'Enter valid price';
                                    } else {
                                      viewModel.productPriceUpdate.value = true;
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  hintText: 'Rs  0.00',
                                  controller: viewModel.prodPriceController,
                                ),
                                CustomTextField2(
                                  title: 'Compare-at-price',
                                  titleColor: newColorLightGrey2,
                                  onChanged: (value) {
                                    viewModel.prodCompareAtPriceController.text = value;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  hintText: 'Rs  0.00',
                                  controller: viewModel.prodCompareAtPriceController,
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                        side: const BorderSide(
                                            color: newColorBlue
                                        ),
                                        fillColor: viewModel.chargeTaxOnProduct.value ? MaterialStateColor.resolveWith((states) => newColorBlue) : MaterialStateColor.resolveWith((states) => Colors.white),
                                        checkColor: Colors.white,
                                        value: viewModel.chargeTaxOnProduct.value,
                                        onChanged: (value) {
                                          viewModel.chargeTaxOnProduct.value = value!;
                                        }
                                    ),
                                    ),
                                    const Text(
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
                                  onChanged: (value) {
                                    viewModel.prodCostPerItemController.text = value;
                                    if (double.parse(viewModel.prodPriceController.text) >= double.parse(value)) {
                                      viewModel.prodProfitController.text = (double.parse(viewModel.prodPriceController.text) - double.parse(value)).toStringAsFixed(2);
                                      double marginAsDouble = (int.parse(value) / int.parse(viewModel.prodPriceController.text) * 100);
                                      int margin = 100 - marginAsDouble.toInt();
                                      viewModel.prodMarginController.text = "$margin%";
                                    } else {
                                      return;
                                    }
                                  },
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
                                  keyboardType: TextInputType.number,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomRoundedTextBtn(
                            borderRadius: 10,
                            backgroundColor: newColorBlue,
                            onPressed: () {
                              if(viewModel.formPriceField.currentState!.validate()){
                                Get.back();
                              }
                            },
                            child: Text(
                              'Done',
                              style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget typeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Type',
              style: dmSansHeading,
            ),
          ),
          InkWell(
            onTap: () {
              productTypeBottomSheet();
            },
            child: Container(
              decoration: textContainerDecoration,
              padding: const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                      viewModel.productType.value == '' ? 'Select product type' : viewModel.productType.value,
                      style: dmSansNormalText.copyWith(
                        fontSize: 14,
                        color: viewModel.productType.value == '' ? newColorLightGrey2 : Colors.black,
                        fontWeight: viewModel.productType.value == '' ? FontWeight.w400 : FontWeight.w500
                      ),
                    ),
                  ),
                  dropDownIcon
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Future productTypeBottomSheet() {
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
                        'Choose Type',
                        style: dmSansHeading.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
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
                  itemCount: viewModel.productTypeList.length,
                  itemBuilder: (context, index) {
                    return BottomSheetItem(
                      title: viewModel.productTypeList[index].name!,
                      onTap: () {
                        viewModel.productType.value = viewModel.productTypeList[index].name!;
                        viewModel.productTypeId = viewModel.productTypeList[index].id!;
                        Get.back();
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

  Widget categoryField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Category',
                style: dmSansHeading,
              ),
            ),
            InkWell(
              onTap: () {
                productCategoryBottomSheet();
              },
              child: Container(
                height: 50,
                decoration: textContainerDecoration,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Obx(() =>
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          viewModel.chosenCategoriesList.isEmpty ? Text(
                            'Select product category',
                            style: dmSansNormalText.copyWith(
                                fontSize: 14,
                                color: newColorLightGrey2,
                                fontWeight: FontWeight.w400
                            ),
                          ) : SizedBox(
                            width: Get.width * 0.75,
                            child: ListView.builder(
                                itemCount: viewModel.chosenCategoriesList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: newColorLightGrey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            viewModel.chosenCategoriesList[index].name!,
                                            style: dmSansNormalText.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 8,),
                                          InkWell(
                                            onTap: () {
                                              viewModel.chosenCategoriesList.removeAt(index);
                                              viewModel.chosenCategoriesList.refresh();
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
                                }
                            ),
                          ),
                          dropDownIcon
                        ]
                    ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Future productCategoryBottomSheet() {
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
                          'Choose Category',
                          style: dmSansHeading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
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
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.productCategoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          viewModel.productCategoryList[index].isSelected = !viewModel.productCategoryList[index].isSelected;
                          viewModel.productCategoryList.refresh();
                          if(viewModel.productCategoryList[index].isSelected) {
                            viewModel.chosenCategoriesList.add(viewModel.productCategoryList[index]);
                          } else {
                            viewModel.chosenCategoriesList.removeWhere((element) => element.id == viewModel.productCategoryList[index].id);
                            viewModel.chosenCategoriesList.refresh();
                          }
                        },
                        child: Container(
                          color: viewModel.productCategoryList[index].isSelected ? newColorLightGrey : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BottomSheetItem(
                                title: viewModel.productCategoryList[index].name!,
                              ),
                              Visibility(
                                visible: viewModel.productCategoryList[index].isSelected,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CustomRoundedTextBtn(
                      onPressed: () => Get.back(),
                    borderRadius: 8,
                    title: 'Done',
                    backgroundColor: newColorBlue,
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  Widget tagsField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Tags',
                style: dmSansHeading,
              ),
            ),
            CustomTextField2(
              focusNode: viewModel.tagsFieldFocusNode,
              onTap: () {
                viewModel.showTagsList.value = true;
              },
              onChanged: (value) {
                if(value == '' || value.isEmpty){
                  viewModel.searchedTags.clear();
                  viewModel.tagsList.forEach((element) {
                    viewModel.searchedTags.add(element);
                  });
                } else {
                  viewModel.searchedTags.clear();
                  viewModel.tagsList.forEach((element) {
                    if(element.name!.toLowerCase().contains(value)){
                      viewModel.searchedTags.add(element);
                      viewModel.searchedTags.refresh();
                    }
                  });
                }
              },
              controller: viewModel.prodTagController,
              prefixIcon: Icons.search,
              hintText: 'Assign tags for this product',
            ),
            tagsDropdown()
            // Container(
            //   height: 50,
            //   decoration: textContainerDecoration,
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: 10, vertical: 12),
            //   child: Obx(() =>
            //       Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             viewModel.chosenCategoriesList.isEmpty ? Text(
            //               'Select product category',
            //               style: dmSansNormalText.copyWith(
            //                   fontSize: 14,
            //                   color: newColorLightGrey2,
            //                   fontWeight: FontWeight.w400
            //               ),
            //             ) : SizedBox(
            //               width: Get.width * 0.75,
            //               child: ListView.builder(
            //                   itemCount: viewModel.chosenCategoriesList.length,
            //                   shrinkWrap: true,
            //                   scrollDirection: Axis.horizontal,
            //                   itemBuilder: (context, index) {
            //                     return Padding(
            //                       padding: const EdgeInsets.only(right: 5.0),
            //                       child: Container(
            //                         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            //                         decoration: BoxDecoration(
            //                           color: newColorLightGrey,
            //                           borderRadius: BorderRadius.circular(5),
            //                         ),
            //                         child: Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             Text(
            //                               viewModel.chosenCategoriesList[index].name!,
            //                               style: dmSansNormalText.copyWith(
            //                                   fontSize: 12,
            //                                   fontWeight: FontWeight.w600
            //                               ),
            //                               overflow: TextOverflow.ellipsis,
            //                             ),
            //                             const SizedBox(width: 8,),
            //                             InkWell(
            //                               onTap: () {
            //                                 viewModel.chosenCategoriesList.removeAt(index);
            //                                 viewModel.chosenCategoriesList.refresh();
            //                               },
            //                               child: const Icon(
            //                                 Icons.close,
            //                                 size: 17,
            //                                 color: newColorLightGrey2,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   }
            //               ),
            //             ),
            //             dropDownIcon
            //           ]
            //       ),
            //   ),
            // ),
          ],
        )
    );
  }

  Widget tagsDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Stack(
        children: [
          SizedBox(
                height: 30,
                child: Obx(() => ListView.builder(
                    itemCount: viewModel.chosenTagsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                            color: newColorLightGrey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                viewModel.chosenTagsList[index].name!,
                                style: dmSansNormalText.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 8,),
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
            // bottom: 10,
            child:
            Obx(() =>
                Visibility(
                  visible: viewModel.showTagsList.value,
                  child:
                  // Icon(Icons.abc, color: Colors.black,)
                  Container(
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
                              viewModel.chosenTagsList.add(
                                  viewModel.searchedTags[index]);
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
                                  visible: viewModel.searchedTags[index].isSelected,
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
              dropdownList: viewModel.locationsList
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