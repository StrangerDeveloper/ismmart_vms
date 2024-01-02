import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/add_product/add_product_1/add_product_1_view.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/add_product_2_viewmodel.dart';
import 'package:ismmart_vms/screens/add_product/add_product_2/location_inventory_view.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../../../helper/constants.dart';
import '../../../widgets/custom_dropdown.dart';
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
              stepperText(),
              variantsContainer(context),
              //if variantAdditionField is clicked and data populated then show the variantsContainer else show the inventoryContainer
              // Obx(() => viewModel.showVariantsTable.value
              //     ? inventoryContainer()
              //     : SizedBox()),
              inventoryContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                child: CustomTextBtn(
                  title: 'Save & Next',
                  onPressed: () {
                    Get.to(() => const LocationInventoryView());
                  },
                ),
              ),
              CustomTextBtn(
                title: 'Back',
                backgroundColor: Colors.black,
                onPressed: () {},
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
          onPressed: () => Get.to(() => AddProduct1View()),
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
              style: interHeadingSize14,
            ),
            Obx(() => viewModel.showVariantsTable.value ? Column(
                children: List.generate(
                  viewModel.listOfOptionsAdded.length,
                  (index) {
                    final option = viewModel.listOfOptionsAdded[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.optionName?.text ?? '',
                                    style: interNormalText.copyWith(
                                      color: newColorLightGrey2
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      option.optionValues?.length ?? 0,
                                      (idx) {
                                        final valueController = option.optionValues?[idx];
                                        return Container(
                                          margin: const EdgeInsets.only(right: 10),
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
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: newColorLightGrey, width: 0.8),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 35,
                                height: 35,
                                child: const Icon(
                                  Icons.edit_rounded,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          Column(
                            children: List.generate(
                              option.optionValues?.length ?? 0,
                                  (idx) {
                                final valueController = option.optionValues?[idx];
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          valueController?.text ?? '',
                                          style: interNormalText,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Rs 0.00',
                                          style: interNormalText.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '0 available at 5 locations',
                                          style: interNormalText.copyWith(
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // viewModel.listOfOptionsAdded.removeWhere(
                                        //     (element) => element == option);
                                        // viewModel.listOfOptionsAdded.refresh();
                                      },
                                      child: const Text(
                                        'Edit',
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ) : const SizedBox()
            ),
            variantAdditionField(context),
          ],
        ),
      ),
    );
  }

  // Widget variantsContainer(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  //       decoration: textContainerDecoration,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Variants',
  //             style: interHeadingSize14,
  //           ),
  //           variantAdditionField(context)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget variantAdditionField(BuildContext context) {
    return Obx(
      () => viewModel.showVariantsField.value
          ? const Column(
              children: [SizedBox()],
            )
          : TextButton(
              onPressed: () async {
                viewModel.showVariantsField.value = false;
                viewModel.listOfOptionsAdded.add(
                  VariantsOptionsFieldModel(
                    optionName: TextEditingController(),
                    optionValues: [TextEditingController()],
                  ),
                );
                await variantSelectionDialog();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '+ Add options like color or size',
                  style: interNormalText.copyWith(
                      color: newColorBlue, fontSize: 12),
                ),
              ),
            ),
    );
  }

  Future variantSelectionDialog() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
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
                    child: Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Variants',
                                  style: interHeadingSize14.copyWith(color: newColorBlue)
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    viewModel.listOfOptionsAdded.clear();
                                    viewModel.listOfOptionsAdded.refresh();
                                    viewModel.showVariantsField.value = false;
                                    viewModel.showVariantsTable.value = false;
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
                                        Obx(() => viewModel.listOfOptionsAdded.isEmpty
                                            ? const SizedBox()
                                            : ListView.builder(
                                          physics: const ScrollPhysics(),
                                          itemCount: viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, optionValueIndex) {
                                            TextEditingController optionController = viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex];
                                            String? title;
                                            if (optionController == viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.first) {
                                              title = 'Option Values';
                                            }
                                            if (viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex] == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.last) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextField4(
                                                      hintText: 'Add value',
                                                      title: title,
                                                      controller: viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[optionValueIndex],
                                                      onChanged: (value) {
                                                        viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex].text = value;
                                                        viewModel.listOfOptionsAdded.refresh();
                                                      },
                                                      iconOnTap: () {
                                                        if(optionValueIndex == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length-1){
                                                          viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                        } else {
                                                          for (int i = optionValueIndex; i <= viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 1; i++) {
                                                            viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[i].text = viewModel.listOfOptionsAdded[optionNameIndex].optionValues![i + 1].text;
                                                            viewModel.listOfOptionsAdded.refresh();
                                                            if (i == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 2) {
                                                              viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.last.dispose();
                                                              viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                            }
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (optionController.text == "" || optionController.text.isEmpty) {
                                                            AppConstant.displaySnackBar('Error', 'Enter Value to add more fields');
                                                          } else {
                                                            viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.add(TextEditingController());
                                                            viewModel.listOfOptionsAdded.refresh();
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Add another value',
                                                          //style: interNormalText.copyWith(color: newColorBlue),
                                                        ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextField4(
                                                      hintText: 'Add value',
                                                      title: title,
                                                      controller: viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[optionValueIndex],
                                                      onChanged: (value) {
                                                        viewModel.listOfOptionsAdded[optionNameIndex].optionValues![optionValueIndex].text =
                                                            value;
                                                        viewModel.listOfOptionsAdded.refresh();
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value == '' ||
                                                            value.isEmpty) {
                                                          return 'Enter value to proceed';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      iconOnTap: () {
                                                        if(optionValueIndex == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length-1){
                                                          viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                        } else {
                                                          for (int i = optionValueIndex; i <= viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 1; i++) {
                                                            viewModel.listOfOptionsAdded[optionNameIndex].optionValues?[i].text = viewModel.listOfOptionsAdded[optionNameIndex].optionValues![i + 1].text;
                                                            viewModel.listOfOptionsAdded.refresh();
                                                            if (i == viewModel.listOfOptionsAdded[optionNameIndex].optionValues!.length - 2) {
                                                              viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.last.dispose();
                                                              viewModel.listOfOptionsAdded[optionNameIndex].optionValues?.removeLast();
                                                            }
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        )
                                        ),
                                        viewModel.listOfOptionsAdded[optionNameIndex] == viewModel.listOfOptionsAdded.last
                                            ? const SizedBox()
                                            : const Padding(
                                          padding:
                                          EdgeInsets.symmetric(vertical: 8),
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
                                      optionValues: [TextEditingController()]));
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
              dropdownList: viewModel.locationsList),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                  color: Colors.black,
                )),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: viewModel.finalCombinationsList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                    value:
                        viewModel.finalCombinationsList[index].variantSelected,
                    onChanged: (value) {
                      viewModel.finalCombinationsList[index].variantSelected =
                          value;
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
                        fontWeight: FontWeight.w400),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget inventoryContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: textContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: interHeadingSize14,
            ),
            Text(
              'Inventory will be stocked at',
              style: interNormalText.copyWith(color: newColorLightGrey2),
            ),
            Obx(
              () => _checkBox(
                'Track quantity',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity',
                  style: interNormalText,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit Locations',
                    style: interNormalText.copyWith(
                        fontWeight: FontWeight.w400, color: newColorBlue),
                  ),
                )
              ],
            ),
            const Divider(),
            _buildField2('Warehouse_1'),
            const SizedBox(
              height: 10,
            ),
            _buildField2('Warehouse_2'),
            const SizedBox(
              height: 10,
            ),
            _buildField2('Warehouse_3'),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => _checkBox(
                'Continue selling when out of stock',
              ),
            ),
            Obx(
              () => _checkBox(
                "This product has a SKU or barcode",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            hsCodeTxtField('SKU (Stock Keeping Unit)'),
            const SizedBox(
              height: 10,
            ),
            hsCodeTxtField('Barcode (ISBN, UPC, GTIN, etc.)'),
          ],
        ),
      ),
    );
  }

  Widget _checkBox(text) {
    return Row(
      children: [
        Checkbox(
            side: const BorderSide(color: newColorBlue),
            fillColor: viewModel.trackQuantity.value
                ? MaterialStateColor.resolveWith((states) => newColorBlue)
                : MaterialStateColor.resolveWith((states) => Colors.white),
            checkColor: Colors.white,
            value: viewModel.trackQuantity.value,
            onChanged: (value) {
              viewModel.trackQuantity.value = value!;
            }),
        Text(
          text,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget hsCodeTxtField(String title) {
    return CustomTextField5(
      title: title,
      //hintText: 'Search by product keyword or code',
    );
  }

  Widget _buildField2(String var1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Warehouse_1',
          style: interNormalText,
        ),
        const SizedBox(
          width: 15,
        ),
        const Expanded(
          child: CustomTextField5(
            hintText: '0',
            suffixIcon: Icons.unfold_more,
          ),
        )
      ],
    );
  }
}
