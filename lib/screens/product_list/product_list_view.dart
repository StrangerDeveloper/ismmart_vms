import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/helper/resourses/app_colors.dart';
import 'package:ismmart_vms/screens/product_list/product_list_viewmodel.dart';
import 'package:ismmart_vms/screens/product_list/product_model.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

class ProductListView extends StatelessWidget {
  ProductListView({super.key});

  final ProductListViewModel viewModel = Get.put(ProductListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // leading: IconButton(
        //     onPressed: () {
        //       Get.to(SettingsView());
        //     },
        //     icon: const Icon(
        //       Icons.menu,
        //       size: 25,
        //       color: Colors.black,
        //     )),
        title: const Text('Products'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110.0),
            child: Column(
              children: [
                addProductSection(),
                filterProductSection(),
              ],
            )),
      ),
      body: Stack(
        children: [
          listView(),
          Obx(
            () => Visibility(
              visible: viewModel.searchByDropdownVisibility.value,
              child: Positioned(
                top: 0,
                left: 25,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: newColorLightGrey2.withOpacity(0.3),
                          width: 0.7),
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width * 0.4,
                  // height: Get.height * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: viewModel.searchFilters.map((e) {
                      return InkWell(
                          onTap: () {
                            viewModel.searchBy.value = e;
                            viewModel.searchByDropdownVisibility.value = false;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 13),
                            child: Text(
                              e,
                              style: interNormalText,
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addProductSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomRoundedTextBtn(
            borderRadius: 12,
            width: Get.width / 2.5,
            onPressed: () {
              // Get.to(AddProduct1View());
              // Get.find<DrawerBottomBarViewModel>().changePage(2);
            },
            title: '+ Add Product',
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: newColorLightGrey2.withOpacity(0.5),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.more_vert_rounded,
                size: 22,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget filterProductSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (viewModel.dropdownSelectionContainerWidth.value <
                    viewModel.searchAndFilterContainerWidth.value) {
                  viewModel.searchAndFilterContainerWidth.value =
                      Get.width * viewModel.lowerContainerWidth;
                  viewModel.dropdownSelectionContainerWidth.value =
                      Get.width * viewModel.higherContainerWidth;
                  Future.delayed(const Duration(microseconds: 100), () {
                    viewModel.searchByContainerIconVisibility.value = true;
                  });
                } else if (viewModel.searchByDropdownVisibility.value) {
                  viewModel.searchByDropdownVisibility.value = false;
                } else {
                  viewModel.searchByDropdownVisibility.value = true;
                }
              },
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  width: viewModel.dropdownSelectionContainerWidth.value,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: newColorLightGrey2.withOpacity(0.5),
                          width: 1.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        viewModel.searchBy.value,
                        style: interNormalText,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Visibility(
                        visible:
                            viewModel.searchByContainerIconVisibility.value,
                        child: Icon(
                          viewModel.searchByDropdownVisibility.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                      )
                      //Obx(() =>)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.v),
          InkWell(
            onTap: () {
              viewModel.dropdownSelectionContainerWidth.value =
                  Get.width * viewModel.lowerContainerWidth;
              viewModel.searchAndFilterContainerWidth.value =
                  Get.width * viewModel.higherContainerWidth;
              viewModel.searchByContainerIconVisibility.value = false;
            },
            child: Obx(
              () => AnimatedContainer(
                padding: const EdgeInsets.all(8),
                width: viewModel.searchAndFilterContainerWidth.value,
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: newColorLightGrey2.withOpacity(0.5),
                        width: 1.2)),
                child: Obx(
                  () => Visibility(
                    visible: viewModel.searchAndFilterIconVisibility.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.search,
                          size: 18,
                          color: newColorLightGrey2,
                        ),
                        InkWell(
                          onTap: () {
                            if (viewModel
                                    .dropdownSelectionContainerWidth.value <
                                Get.width * viewModel.higherContainerWidth) {
                              return;
                            } else {
                              viewModel.filterDropdownVisibility.value =
                                  !viewModel.filterDropdownVisibility.value;
                            }
                          },
                          child: const Icon(
                            Icons.filter_list_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: viewModel.productItemsList.isEmpty
                    ? [
                        Center(
                          child: Text(
                            'No Products Found',
                            style: interHeadingSize14.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        )
                      ]
                    : [
                        nextPageData(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: newColorLightGrey2.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.productItemsList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int index) {
                              ProductsItem items =
                                  viewModel.productItemsList[index];
                              return listViewItem(model: items);
                            },
                          ),
                        ),
                      ],
              )),
        ));
  }

  Widget listViewItem({ProductsItem? model}) {
    //var rng = Random();
    return InkWell(
      onTap: () {
        //Get.to(() => ProductDetailView());
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 45,
              width: 45,
              imageUrl: model!.media![0].url!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/no_image_found.jpg'),
                      fit: BoxFit.cover,
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: interHeadingSize14.copyWith(color: newColorBlue),
                ),
                SizedBox(height: 3.h),
                // Row(
                //   children: [
                //     Text(
                //       '• Category: ${model.categories![0].name}',
                //       style: interNormalText.copyWith(
                //           color: newColorLightGrey2, fontSize: 11),
                //     ),
                //     SizedBox(width: 10.v),
                //     Text(
                //       '• Variants: ${model.variants}',
                //       style: interNormalText.copyWith(
                //           color: newColorLightGrey2, fontSize: 11),
                //     ),
                //   ],
                // ),
                Text(
                  '• Category: ${model.categories![0].name}',
                  style: interNormalText.copyWith(
                      color: newColorLightGrey2, fontSize: 11),
                ),
                Text(
                  '• Variants: ${model.variants}',
                  style: interNormalText.copyWith(
                      color: newColorLightGrey2, fontSize: 11),
                ),
                SizedBox(height: 15.h),

                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: model.status!.toLowerCase().contains("active")
                          ? productActiveColor.withOpacity(0.25)
                          : newColorLightGrey2.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor:
                            model.status!.toLowerCase().contains("active")
                                ? productActiveColor
                                : newColorLightGrey2,
                      ),
                      SizedBox(width: 10.v),
                      Text(
                        "${model.status}",
                        style: interNormalText.copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: newColorLightGrey2,
                  height: 2,
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Product Name',
            //         style: interHeadingSize14.copyWith(color: newColorBlue),
            //       ),
            //       const SizedBox(
            //         height: 7,
            //       ),
            //       const SizedBox(
            //         height: 5,
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //             'Category',
            //             style: interNormalText.copyWith(
            //                 color: newColorLightGrey2, fontSize: 11),
            //           ),
            //           const SizedBox(
            //             width: 10,
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 15,
            //       ),
            // Container(
            //   padding: const EdgeInsets.all(6),
            //   decoration: BoxDecoration(
            //       color: index % 2 == 0
            //           ? productActiveColor.withOpacity(0.25)
            //           : newColorLightGrey2.withOpacity(0.25),
            //       borderRadius: BorderRadius.circular(15)),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       CircleAvatar(
            //         radius: 5,
            //         backgroundColor: index % 2 == 0
            //             ? productActiveColor
            //             : newColorLightGrey2,
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         index % 2 == 0 ? 'Active' : 'Draft',
            //         style: interNormalText.copyWith(
            //             color: Colors.black,
            //             fontSize: 10,
            //             fontWeight: FontWeight.w400),
            //       )
            //     ],
            //   ),
            // ),
            // ],
            //),
            //),
          ],
        ),
      ),
    );
  }

  Widget nextPageData() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              '${viewModel.productModel.value.page} - ${viewModel.productModel.value.pages} of ${viewModel.productModel.value.total}',
              style: interNormalText.copyWith(
                  color: gray900, fontWeight: FontWeight.w400, fontSize: 11),
            ),
          ),
          Row(
            children: [
              CustomIconBtn(
                iconSize: 10,
                enabled: false,
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 5),
              CustomIconBtn(
                iconSize: 10,
                enabled: true,
                icon: Icons.arrow_forward_ios_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
