import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/variant_selection_model.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_viewmodel.dart';
import 'package:ismmart_vms/screens/location_list/location_list_view.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../../helper/constants.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/stepperText.dart';
import '../../../widgets/widget_models/variant_options_field_model.dart';

class AddProduct2View extends StatelessWidget {
  AddProduct2View({super.key});

  final AddProduct2ViewModel viewModel = Get.put(AddProduct2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              stepperText(2),
              variantsContainer(context),
              inventoryContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: CustomTextBtn(
                  title: 'Save & Next',
                  onPressed: () {
                    if(viewModel.finalCombinationsList.isEmpty) {
                      AppConstant.displaySnackBar('Error', 'Create atleast one variant to proceed');
                    } else {
                      viewModel.createJson();
                    }
                  },
                ),
              ),
              CustomTextBtn(
                title: 'Back',
                backgroundColor: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
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

  Widget variantsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: textContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Variants',
              style: interHeadingSize15,
            ),
            Obx(() => viewModel.showVariantsData.value ? Column(
                children: [
                   variantNameAndValues(),
                  Divider(
                    thickness: 0.8,
                    color: newColorLightGrey2.withOpacity(0.6),
                  ),
                  combinationsAndInventory()
                ]
              ) : const SizedBox()
            ),
            variantAdditionBtn(context),
          ],
        ),
      ),
    );
  }

  Widget variantNameAndValues() {
    return Obx(() => Column(
        children: List.generate(
          viewModel.listOfOptionsAdded.length,
              (index) {
            final option = viewModel.listOfOptionsAdded[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option.optionName?.text ?? '',
                            style: interNormalText.copyWith(
                                color: newColorLightGrey3
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await variantCreationDialog(index: index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kContainerFillColor,
                                  border: Border.all(color: newColorLightGrey),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 35,
                              height: 35,
                              child: const Icon(
                                Icons.edit_rounded,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      SizedBox(
                        width: Get.width,
                        child: Wrap(
                          children: List.generate(
                              option.optionValues!.length,
                                  (idx) {
                                final valueController = option.optionValues?[idx];
                                return Container(
                                  margin: const EdgeInsets.only(right: 10, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    valueController?.text ?? '',
                                    style: interNormalText.copyWith(
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget combinationsAndInventory() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Showing ${viewModel.finalCombinationsList.length} variant(s)',
            style: interHeadingSize15.copyWith(
              fontSize: 14,
              color: newColorLightGrey2,
              fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 5,),
          Column(
            children: List.generate(
                viewModel.finalCombinationsList.length, (idx) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            viewModel.finalCombinationsList[idx].variantName!,
                            style: interHeadingSize15.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                List<VariantSelectionModel> tempList = <VariantSelectionModel>[];
                                viewModel.finalCombinationsList.forEach((element) async {
                                  tempList.add(element);
                                  if(element == viewModel.finalCombinationsList.last){
                                    await inventoryBottomSheet(idx, false, tempList);
                                  }
                                });
                              },
                              child: Text(
                                'Edit',
                                style: interNormalText.copyWith(
                                    color: newColorBlue, fontSize: 12),
                              )
                          )
                        ],
                      ),
                      Text(
                        viewModel.finalCombinationsList[idx].variantValue == null ? 'Rs 0.00' : 'Rs ${viewModel.finalCombinationsList[idx].variantValue}',
                        style: interNormalText.copyWith(
                          fontWeight: FontWeight.w400,
                          color: newColorLightGrey2,
                          fontSize: 10
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        '${viewModel.finalCombinationsList[idx].totalInventoryQuantityValue} available at ${viewModel.locationInventoryList.length} locations',
                        style: interNormalText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: newColorLightGrey2,
                            fontSize: 10
                        ),
                      )
                    ],
                  );
            }),
          )
        ]
      ),
    );
  }

  Widget _checkBox(text, RxBool checkValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Obx(() => AnimatedContainer(
            height: 20,
            width: 20,
            margin: const EdgeInsets.only(right: 8),
            duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: checkValue.value ? newColorBlue : Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: checkValue.value ? newColorBlue : newColorLightGrey2,
                  )
                ),
            child: InkWell(
                onTap: () {
                  checkValue.value = !checkValue.value;
                },
                child: checkValue.value ? const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 15,
              ),
            ) : const SizedBox()
              ),
          ),
          ),
          Text(
            text,
            style: interNormalText.copyWith(
              color: newColorLightGrey2,
              fontWeight: FontWeight.w400,
              fontSize: 11
            ),
          )
        ],
      ),
    );
  }

  Widget variantAdditionBtn(BuildContext context) {
    return TextButton(
      onPressed: () async {
        viewModel.listOfOptionsAdded.add(
          VariantsOptionsFieldModel(
            optionName: TextEditingController(),
            optionValues: [TextEditingController()],
          ),
        );
        await variantCreationDialog();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '+ Add options like color or size',
          style: interNormalText.copyWith(
              color: newColorBlue, fontSize: 12),
        ),
      ),
    );
  }

  Future variantCreationDialog({int? index}) {
    if (index == null) {
      return showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))
          ),
          context: Get.context!,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Form(
                  key: viewModel.variantsFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      controller: viewModel.scrollController,
                      physics: const ScrollPhysics(),
                      child: Obx(() =>
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Variants',
                                        style: interHeadingSize15.copyWith(color: newColorBlue)
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        if (viewModel.listOfOptionsAdded.length > 1) {
                                          List<int> indexesToRemove = <int>[];
                                          for (int i = 0; i <= viewModel.listOfOptionsAdded.length - 1; i++) {
                                            if (viewModel.listOfOptionsAdded[i].optionName?.text == '') {
                                              indexesToRemove.add(i);
                                              if (i == viewModel.listOfOptionsAdded.length - 1 &&
                                                  indexesToRemove.length == viewModel.listOfOptionsAdded.length) {
                                                final indexesToRemoveReversed = indexesToRemove.reversed;
                                                viewModel.checkAndClearVariantBottomSheet(indexesToRemoveReversed.toList());
                                              } else if (i == viewModel.listOfOptionsAdded.length - 1) {
                                                final indexesToRemoveReversed = indexesToRemove.reversed;
                                                viewModel.checkAndClearVariantBottomSheet(indexesToRemoveReversed.toList());
                                              }
                                            }
                                          }
                                        } else {
                                          if (viewModel.listOfOptionsAdded[0].optionName?.text == '') {
                                            viewModel.listOfOptionsAdded.removeLast();
                                            viewModel.listOfOptionsAdded.refresh();
                                            Get.back();
                                          } else {
                                            Get.back();
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                                child: ListView.builder(
                                    itemCount: viewModel.listOfOptionsAdded.length,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, optionNameIndex) {
                                      TextEditingController optionName = TextEditingController();
                                      optionName.text = viewModel.listOfOptionsAdded[optionNameIndex].optionName!.text;
                                      return Column(
                                        children: [
                                          CustomTextField4(
                                            title: 'Option Name',
                                            hintText: 'Name your variant',
                                            controller: viewModel.listOfOptionsAdded[optionNameIndex].optionName,
                                            onChanged: (value) {
                                              viewModel.listOfOptionsAdded[optionNameIndex].optionName?.text = value;
                                              viewModel.listOfOptionsAdded.refresh();
                                            },
                                            validator: (value) {
                                              if (value == null || value == "" || value.isEmpty) {
                                                return 'Enter name for variant';
                                              } else {
                                                return null;
                                              }
                                            },
                                            iconOnTap: () {
                                              viewModel.listOfOptionsAdded.remove(viewModel.listOfOptionsAdded[optionNameIndex]);
                                              viewModel.listOfOptionsAdded.refresh();
                                            },
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Divider(
                                              thickness: 0.8,
                                              color: kLightColor,
                                            ),
                                          ),
                                          Obx(() =>
                                          viewModel.listOfOptionsAdded.isEmpty
                                              ? const SizedBox()
                                              : ListView.builder(
                                            physics: const ScrollPhysics(),
                                            itemCount: viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, optionValueIndex) {
                                              TextEditingController optionController = viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex];
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 5.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomTextField4(
                                                        hintText: 'Add value',
                                                        title: optionController == viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.first ? 'Option Values' : null,
                                                        controller: viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[optionValueIndex],
                                                        onChanged: (value) {
                                                          viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex].text = value;
                                                          viewModel.listOfOptionsAdded.refresh();
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value == '' || value.isEmpty) {
                                                            return 'Option value is required';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        iconOnTap: () {
                                                          if(viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length > 1){
                                                            if (optionValueIndex == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 1) {
                                                              viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                              viewModel.listOfOptionsAdded.refresh();
                                                            } else {
                                                              for (int i = optionValueIndex; i <= viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length; i++) {
                                                                viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[i].text = viewModel.listOfOptionsAdded[optionNameIndex].optionValues![i + 1].text;
                                                                viewModel.listOfOptionsAdded.refresh();
                                                                if (i == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 2) {
                                                                  viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.last.dispose();
                                                                  viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            Get.back();
                                                            viewModel.listOfOptionsAdded.removeAt(optionNameIndex);
                                                            viewModel.listOfOptionsAdded.refresh();
                                                            if(viewModel.listOfOptionsAdded.isEmpty) {
                                                              viewModel.showVariantsData.value = false;
                                                            } else {
                                                              viewModel.creatingVariants();
                                                            }
                                                          }
                                                        },
                                                      ),
                                                      viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex] == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.last ? TextButton(
                                                        onPressed: () {
                                                          if (optionController.text == "" || optionController.text.isEmpty) {
                                                            AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                                                          } else {
                                                            viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.add(TextEditingController());
                                                            viewModel.listOfOptionsAdded.refresh();
                                                            viewModel.focusNode.requestFocus();
                                                          }
                                                        },
                                                        child: Text(
                                                          'Add another value',
                                                          style: interNormalText.copyWith(
                                                              color: newColorBlue,
                                                              fontSize: 12
                                                          ),
                                                        ),
                                                      ) : const SizedBox()
                                                    ],
                                                  ),
                                                );
                                            },
                                          )
                                          ),
                                          viewModel.listOfOptionsAdded[optionNameIndex] == viewModel.listOfOptionsAdded.last ? const SizedBox()
                                              : const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 8),
                                            child: Divider(
                                              thickness: 1.3,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              TextButton(
                                onPressed: () {
                                  viewModel.listOfOptionsAdded.add(
                                      VariantsOptionsFieldModel(
                                          optionName: TextEditingController(),
                                          optionValues: [
                                            TextEditingController()
                                          ]));
                                  viewModel.listOfOptionsAdded.refresh();
                                },
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '+ Add another Option',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                child: CustomRoundedTextBtn(
                                  onPressed: () {
                                    if (viewModel.variantsFormKey.currentState!.validate()) {
                                      viewModel.creatingVariants();
                                      Get.back();
                                    }
                                  },
                                  title: 'Done',
                                  borderRadius: 8,
                                  backgroundColor: newColorBlue,
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      return showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))
          ),
          context: Get.context!,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Form(
                  key: viewModel.variantsFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      controller: viewModel.scrollController,
                      physics: const ScrollPhysics(),
                      child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Variants',
                                        style: interHeadingSize15.copyWith(color: newColorBlue)
                                    ),
                                    IconButton(
                                      visualDensity: VisualDensity.compact,
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
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                                child: Column(
                                        children: [
                                          CustomTextField4(
                                                title: 'Option Name',
                                                hintText: 'Name your variant',
                                                controller: viewModel.listOfOptionsAdded[index].optionName,
                                                onChanged: (value) {
                                                  viewModel.listOfOptionsAdded[index].optionName?.text = value;
                                                  viewModel.listOfOptionsAdded.refresh();
                                                },
                                                validator: (value) {
                                                  if (value == null || value == "" || value.isEmpty) {
                                                    return 'Enter name for variant';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                iconOnTap: () {
                                                  Get.back();
                                                  viewModel.listOfOptionsAdded.removeAt(index);
                                                  viewModel.listOfOptionsAdded.refresh();
                                                  if(viewModel.listOfOptionsAdded.isEmpty) {
                                                    viewModel.showVariantsData.value = false;
                                                  } else {
                                                    viewModel.creatingVariants();
                                                  }
                                                },
                                              ),

                                          const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Divider(
                                              thickness: 0.8,
                                              color: kLightColor,
                                            ),
                                          ),
                                          ListView.builder(
                                            physics: const ScrollPhysics(),
                                            itemCount: viewModel.listOfOptionsAdded[index].optionValues?.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, optionValueIndex) {
                                              TextEditingController optionController = viewModel.listOfOptionsAdded[index].optionValues![optionValueIndex];
                                                return Padding(
                                                  padding: const EdgeInsets.only(bottom: 5.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomTextField4(
                                                        hintText: 'Add value',
                                                        title: optionController == viewModel.listOfOptionsAdded[index].optionValues?.first ? 'Option Values' : null,
                                                        controller: viewModel.listOfOptionsAdded[index].optionValues?[optionValueIndex],
                                                        onChanged: (value) {
                                                          viewModel.listOfOptionsAdded[index].optionValues![optionValueIndex].text = value;
                                                          viewModel.listOfOptionsAdded.refresh();
                                                        },
                                                        validator: (value) {
                                                          if (value == null || value == '' || value.isEmpty) {
                                                            return 'Option value is required';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        iconOnTap: () {
                                                          if(viewModel.listOfOptionsAdded[index].optionValues!.length > 1){
                                                            if (optionValueIndex == viewModel.listOfOptionsAdded[index].optionValues!.length - 1) {
                                                              viewModel.listOfOptionsAdded[index].optionValues?.removeLast();
                                                              viewModel.listOfOptionsAdded.refresh();
                                                            } else {
                                                              for (int i = optionValueIndex; i <= viewModel.listOfOptionsAdded[index].optionValues!.length - 1 ; i++) {
                                                                viewModel.listOfOptionsAdded[index].optionValues?[i].text = viewModel.listOfOptionsAdded[index].optionValues![i + 1].text;
                                                                viewModel.listOfOptionsAdded.refresh();
                                                                if (i == viewModel.listOfOptionsAdded[index].optionValues!.length - 2) {
                                                                  viewModel.listOfOptionsAdded[index].optionValues?.last.dispose();
                                                                  viewModel.listOfOptionsAdded[index].optionValues?.removeLast();
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            Get.back();
                                                            viewModel.listOfOptionsAdded.removeAt(index);
                                                            viewModel.listOfOptionsAdded.refresh();
                                                            if(viewModel.listOfOptionsAdded.isEmpty) {
                                                              viewModel.showVariantsData.value = false;
                                                            } else {
                                                              viewModel.creatingVariants();
                                                            }
                                                          }
                                                        },
                                                      ),
                                                      viewModel.listOfOptionsAdded[index].optionValues![optionValueIndex] == viewModel.listOfOptionsAdded[index].optionValues!.last ? TextButton(
                                                        onPressed: () {
                                                          if (optionController.text == "" || optionController.text.isEmpty) {
                                                            AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                                                          } else {
                                                            viewModel.listOfOptionsAdded[index].optionValues?.add(TextEditingController());
                                                            viewModel.listOfOptionsAdded.refresh();
                                                          }
                                                        },
                                                        child: Text(
                                                          'Add another value',
                                                          style: interNormalText.copyWith(
                                                              color: newColorBlue,
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                      ) : const SizedBox()
                                                    ],
                                                  ),
                                                );
                                            },
                                          )
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                child: CustomRoundedTextBtn(
                                  onPressed: () {
                                    if (viewModel.variantsFormKey.currentState!.validate()) {
                                      viewModel.creatingVariants();
                                      Get.back();
                                    }
                                  },
                                  title: 'Done',
                                  borderRadius: 8,
                                  backgroundColor: newColorBlue,
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),
                ),
            );
          });
    }
  }

  Widget inventoryContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const   EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: textContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: interHeadingSize15,
            ),
            const SizedBox(height: 8,),
            Text(
              'Inventory will be stocked at',
              style: interNormalText.copyWith(
                  color: newColorLightGrey2,
                  fontSize: 13
              ),
            ),
            _checkBox('Track quantity', viewModel.trackQuantity),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Locations',
                  style: interNormalText,
                ),
                Obx(() => viewModel.locationInventoryList.isEmpty ? const SizedBox() : TextButton(
                    onPressed: () {
                      Get.to(() => LocationListView(), arguments: {'cameFromAddProduct': true});
                    },
                    child: Text(
                      'Edit Locations',
                      style: interNormalText.copyWith(
                          fontWeight: FontWeight.w400, color: newColorBlue),
                    ),
                  ),
                )
              ],
            ),
            Obx(() => viewModel.locationInventoryList.isEmpty ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: newColorLightGrey2,
              ),
            ) : Column(
                children: List.generate(
                    viewModel.locationInventoryList.length,
                        (idx) {
                      return inventoryLocationTile(viewModel.locationInventoryList[idx].name!, idx);
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inventoryLocationTile(String locationName, int index) {
    return Column(
      children: [
        const Divider(thickness: 1,color: newColorLightGrey,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: InkWell(
            onTap: () {
              if(viewModel.finalCombinationsList.isEmpty) {
                AppConstant.displaySnackBar('Error', 'Add Variants to Proceed');
              } else {
                List<VariantSelectionModel> tempList = <VariantSelectionModel>[];
                viewModel.finalCombinationsList.forEach((element) async {
                  tempList.add(element);
                  if(element == viewModel.finalCombinationsList.last){
                    await inventoryBottomSheet(index, true, tempList);
                  }
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                        Icons.location_pin,
                      color: newColorLightGrey2,
                      size: 20,
                    ),
                    const SizedBox(width: 10,),
                    Text(
                      locationName,
                      style: interNormalText.copyWith(
                        color: newColorLightGrey3,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future inventoryBottomSheet(int index, bool forOneLocation, List<VariantSelectionModel> tempList) {

    if(forOneLocation) {
      return showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          useSafeArea: true,
          isScrollControlled: true,
          context: Get.context!,
          builder: (BuildContext context){
            return PopScope(
              canPop: false,
              child: SizedBox(
                height: Get.height * 0.85,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Form(
                    key: viewModel.variantsInventoryFormKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SingleChildScrollView(
                       physics: const ScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Location Inventory',
                                      style: interHeadingSize15.copyWith(color: newColorBlue)
                                  ),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      viewModel.finalCombinationsList.clear();
                                      for (var element in tempList) {
                                        viewModel.finalCombinationsList.add(element);
                                        }
                                      viewModel.finalCombinationsList.refresh();
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: newColorLightGrey2,
                                      ),
                                      const SizedBox(width: 10,),
                                      Text(
                                        viewModel.locationInventoryList[index].name!,
                                        style: interHeadingSize15.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            textContainer(5, 'Variant', false),
                                            textContainer(6, 'Price', true),
                                            const SizedBox(width: 10,),
                                            textContainer(6, 'Quantity', true),
                                          ],
                                        ),
                                        const Divider(),
                                        Column(
                                          children: List.generate(
                                              viewModel.finalCombinationsList.length, (idx) {
                                            int locationIndexInInventory = viewModel.finalCombinationsList[idx].locationInventory!.indexWhere((element) => element.locationName == viewModel.locationInventoryList[index].name);
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  width: Get.width,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          viewModel.finalCombinationsList[idx].variantName!,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: interNormalText.copyWith(
                                                              color: newColorBlue,
                                                              fontSize: 14
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 6,
                                                        child: CustomTextField2(
                                                          initialValue: viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].price == null ? '' : "${viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].price}",
                                                          onChanged: (value) {
                                                            viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].price = double.parse(value);
                                                            viewModel.finalCombinationsList.refresh();
                                                          },
                                                          hintText: 'Rs  0.00',
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          keyboardType: TextInputType.number,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      Expanded(
                                                        flex: 6,
                                                        child: CustomTextField2(
                                                          initialValue: viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].quantity == null ? '' : "${viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].quantity}",
                                                          onChanged: (value) {
                                                            viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].quantity = int.parse(value);
                                                            viewModel.finalCombinationsList.refresh();
                                                          },
                                                          hintText: '0',
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          keyboardType: TextInputType.number,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20,),
                                                CustomTextField2(
                                                  initialValue: viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].sku ?? '',
                                                  fillColor: kContainerFillColor,
                                                  titleTextStyle: interNormalText.copyWith(
                                                      color: newColorLightGrey3,
                                                      fontSize: 13
                                                  ),
                                                  onChanged: (value) {
                                                    viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].sku = value;
                                                    viewModel.finalCombinationsList.refresh();
                                                  },
                                                  title: 'SKU (Stock Keeping Unit)',
                                                ),
                                                const SizedBox(height: 8,),
                                                CustomTextField2(
                                                  initialValue: viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].barcode ?? '',
                                                  fillColor: kContainerFillColor,
                                                  titleTextStyle: interNormalText.copyWith(
                                                      color: newColorLightGrey3,
                                                      fontSize: 13
                                                  ),
                                                  onChanged: (value) {
                                                    viewModel.finalCombinationsList[idx].locationInventory?[locationIndexInInventory].barcode = value;
                                                    viewModel.finalCombinationsList.refresh();
                                                  },
                                                  title: 'Barcode (ISBN, UPC, GTIN etc.',
                                                ),
                                                const Divider()
                                              ],
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: CustomRoundedTextBtn(
                                onPressed: () {
                                  Get.back();
                                },
                                title: 'Done',
                                borderRadius: 8,
                                backgroundColor: newColorBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      );
    } else {
      return showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          useSafeArea: true,
          isScrollControlled: true,
          context: Get.context!,
          builder: (BuildContext context){
            return PopScope(
              canPop: false,
              child: SizedBox(
                height: Get.height * 0.85,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Form(
                    key: viewModel.variantsInventoryFormKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SingleChildScrollView(
                        // controller: viewModel.scrollController,
                        physics: const ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      viewModel.finalCombinationsList[index].variantName!,
                                      maxLines: 2,
                                      style: interHeadingSize15.copyWith(color: newColorBlue)
                                  ),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                      onPressed: (){
                                        viewModel.finalCombinationsList.clear();
                                        for (var element in tempList) {
                                          viewModel.finalCombinationsList.add(element);
                                        }
                                        viewModel.finalCombinationsList.refresh();
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.red,
                                      )
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            textContainer(6, 'Location Name', false),
                                            textContainer(5, 'Price', true),
                                            const SizedBox(width: 10,),
                                            textContainer(5, 'Quantity', true),
                                          ],
                                        ),
                                        const Divider(),
                                        Column(
                                          children: List.generate(
                                              viewModel.finalCombinationsList[index].locationInventory!.length, (idx) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(
                                                  width: Get.width,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                          viewModel.finalCombinationsList[index].locationInventory![idx].locationName!,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: interNormalText.copyWith(
                                                              color: newColorBlue,
                                                              fontSize: 14
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: CustomTextField2(
                                                          initialValue: viewModel.finalCombinationsList[index].locationInventory?[idx].price == null ? '' : "${viewModel.finalCombinationsList[index].locationInventory?[idx].price}",
                                                          onChanged: (value) {
                                                            viewModel.finalCombinationsList[index].locationInventory?[idx].price = double.parse(value);
                                                            viewModel.finalCombinationsList.refresh();
                                                          },
                                                          hintText: 'Rs  0.00',
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          keyboardType: TextInputType.number,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      Expanded(
                                                        flex: 5,
                                                        child: CustomTextField2(
                                                          initialValue: viewModel.finalCombinationsList[index].locationInventory?[idx].quantity == null ? '' : "${viewModel.finalCombinationsList[index].locationInventory?[idx].quantity}",
                                                          onChanged: (value) {
                                                            viewModel.finalCombinationsList[index].locationInventory?[idx].quantity = int.parse(value);
                                                            viewModel.finalCombinationsList.refresh();
                                                          },
                                                          hintText: '0',
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                            FilteringTextInputFormatter.digitsOnly
                                                          ],
                                                          keyboardType: TextInputType.number,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20,),
                                                CustomTextField2(
                                                  initialValue: viewModel.finalCombinationsList[index].locationInventory?[idx].sku ?? '',
                                                  fillColor: kContainerFillColor,
                                                  titleTextStyle: interNormalText.copyWith(
                                                      color: newColorLightGrey3,
                                                      fontSize: 13
                                                  ),
                                                  onChanged: (value) {
                                                    viewModel.finalCombinationsList[index].locationInventory?[idx].sku = value;
                                                    viewModel.finalCombinationsList.refresh();
                                                  },
                                                  title: 'SKU (Stock Keeping Unit)',
                                                ),
                                                const SizedBox(height: 8,),
                                                CustomTextField2(
                                                  initialValue: viewModel.finalCombinationsList[index].locationInventory?[idx].barcode ?? '',
                                                  fillColor: kContainerFillColor,
                                                  titleTextStyle: interNormalText.copyWith(
                                                      color: newColorLightGrey3,
                                                      fontSize: 13
                                                  ),
                                                  onChanged: (value) {
                                                    viewModel.finalCombinationsList[index].locationInventory?[idx].barcode = value;
                                                    viewModel.finalCombinationsList.refresh();
                                                  },
                                                  title: 'Barcode (ISBN, UPC, GTIN etc.',
                                                ),
                                                const Divider()
                                              ],
                                            );
                                          }),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                              child: CustomRoundedTextBtn(
                                onPressed: () {
                                  Get.back();
                                },
                                title: 'Done',
                                borderRadius: 8,
                                backgroundColor: newColorBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      );
    }
  }

  Widget textContainer(int flexValue, String text, bool centerTitle) {
    return Expanded(
      flex: flexValue,
      child: centerTitle ? Center(
        child: Text(
          text,
          style: interNormalText.copyWith(
              fontSize: 12
          ),
        ),
      ) : Text(
        text,
        style: interNormalText.copyWith(
            fontSize: 12
        ),
      ),
    );
  }
}
