import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';
import 'package:ismmart_vms/widgets/custom_text.dart';
import '../../helper/constants.dart';
import '../../widgets/custom_button.dart';
import 'collection_viewmodel.dart';

class CollectionListView extends StatelessWidget {
  CollectionListView({super.key});

  final CollectionViewModel viewModel = Get.put(CollectionViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  titleAndBackBtn(),
                  divider(),
                  createCollRow(),
                  navigationRow(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 700,
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9FAFB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: listViewItem()),
                  )
                ]))));
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomBackButton(onTap: () {
              Get.back();
            }),
          ),
          const SizedBox(width: 100),
          Text(
            'Create Collection',
            style: newFontStyleSize20DM,
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: Color(0xffEEEEEE),
      thickness: 1,
      height: 20,
    );
  }

  Widget createCollectionBtn() {
    return SizedBox(
      width: 165,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CustomTextBtn(
          radius: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                size: 20,
              ),
              SizedBox(width: 4.h),
              const Text(
                'Create Collection',
                // style: newFontStyleSize14.copyWith(
                //     fontWeight: FontWeight.w500, color: kWhiteColor),kWhiteColor
              ),
            ],
          ),
          onPressed: () {
            viewModel.getCollection();
            // Get.offNamed(Routes.dashboard);
            //
          },
        ),
      ),
    );
  }

  Widget createCollRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createCollectionBtn(),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              width: 62,
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 5),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: newColorLightGrey2,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.filter_list,
                    color: newColorLightGrey2,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationRow() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: "1 - 10  of  50",
            style: newFontStyleSize16.copyWith(
                fontWeight: FontWeight.w700, color: newColorLightGrey2),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: ThemeHelper.grey2,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: ThemeHelper.grey2,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget listViewItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 20),
      child: SizedBox(
          height: 600,
          child: ListView.builder(
              itemCount: viewModel.collectionList.length,
              itemBuilder: (BuildContext context, index) {
                var item = viewModel.collectionList[index];
                return SizedBox(
                  width: 295,
                  height: 87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Image.network(
                              "https://via.placeholder.com/40x40")),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            title: item.name.toString(),
                            style: newFontStyleSize14.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '784 products',
                            style: newFontStyleSize12Grey2,
                          ),
                          Text(
                            'Product tag is equal to women clothes',
                            style: newFontStyleSize12Grey2,
                          ),
                          Text(
                            'Product tag is equal to 2 piece suit',
                            style: newFontStyleSize12Grey2,
                          )
                        ],
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
