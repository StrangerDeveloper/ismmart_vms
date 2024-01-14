import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/global_variables.dart';
import 'package:ismmart_vms/helper/languages/translations_key.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/model/pictures_model.dart';
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
                    // backgroundColor: viewModel.cameFromProductList.value && identical(viewModel.productDetails.value, viewModel.tempModel) ? ThemeHelper.blue1 : ThemeHelper.blue1.withOpacity(0.7),
                    onPressed: () {
                        viewModel.proceed();
                      },
                      title: 'Save & Continue',
                    ),
                  CustomTextBtn(
                    title: 'Back',
                    backgroundColor: Colors.black,
                    onPressed: () => Get.back(),
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
        viewModel.editProduct.value ? 'Edit Product' : 'Add Product',
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
            .validateName(value, errorToPrompt: productNameReq.tr);
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
                    textStyle: const TextStyle(
                      color: ThemeHelper.grey4,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
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
          width: Get.width,
          // padding: viewModel.productImagesList.isEmpty ? null : const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: viewModel.productImagesUploadCheck.value || viewModel.imagesThumbnailCheck.value ? Colors.red.shade700 : viewModel.productImagesList.isNotEmpty ? Colors.white : ThemeHelper.grey1,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                      thumbnail: true,
                                    )
                                );
                                viewModel.productImagesList.refresh();
                              } else {
                                viewModel.productImagesList.add(
                                    PicturesModel(
                                      fileName: splitted.last,
                                      filePath: element.path,
                                      thumbnail: false,
                                    )
                                );
                                viewModel.productImagesList.refresh();
                                viewModel.imagesChanged = true;
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
                ),
              SizedBox(height: viewModel.productImagesList.isEmpty ? 0 : 5,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    children: viewModel.productImagesList.isNotEmpty ? List.generate(
                        viewModel.productImagesList.length,
                            (idx) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Stack(
                                children: [
                                  viewModel.productImagesList[idx].url == null ? Container(
                                    height: 55,
                                    width: 55,
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.fill, image: FileImage(File(viewModel.productImagesList[idx].filePath!))),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ) : CachedNetworkImage(
                                    height: 55,
                                    width: 60,
                                    imageUrl: viewModel.productImagesList[idx].url != null ? '${viewModel.productImagesList[idx].url}' : '',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: const DecorationImage(
                                            image: AssetImage('assets/logo/logo_new.png'),
                                            fit: BoxFit.fill,
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
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        viewModel.productImagesList.removeAt(idx);
                                        viewModel.productImagesList.refresh();
                                      },
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.close,
                                          size: 8,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          );
                        }
                    ) : [],
                  )
                ],
              ),
            ],
          )
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

  Widget typeTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Obx(() => CustomTextField1(
          refreshIconVisibility: viewModel.typeRefreshCheck.value,
          onIconTap: () => viewModel.fetchTypes(),
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
      ),
    );
  }

  Widget categoryTxtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => CustomTextField1(
          refreshIconVisibility: viewModel.categoryRefreshCheck.value,
            onIconTap: () {
              viewModel.fetchCategories();
            },
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
                  viewModel.categoriesChanged = true;
                },
              ).show();
            },
          ),
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
                            int categoryIndex = viewModel.productCategoryList.indexWhere((element) => element.id == viewModel.chosenCategoriesList[index].id);
                            if(categoryIndex == -1) {
                              viewModel.productCategoryList.insert(viewModel.chosenCategoriesList[index].oldIndex ?? viewModel.productCategoryList.length, viewModel.chosenCategoriesList[index]);
                              viewModel.chosenCategoriesList.removeAt(index);
                              viewModel.chosenCategoriesList.refresh();
                            } else {
                              viewModel.chosenCategoriesList.removeAt(index);
                              viewModel.chosenCategoriesList.refresh();
                            }
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
                viewModel.tagsChanged = true;
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