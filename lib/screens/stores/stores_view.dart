import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/screens/stores/store_editview.dart';

import '../../helper/constants.dart';
import '../../helper/global_variables.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loading.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          titleAndBackBtn(),
          const Divider(
            color: Color(0xffEEEEEE),
            thickness: 1,
            height: 20,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: Get.width * .8,
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Store Info',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.09,
                    letterSpacing: 0.30,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 250,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFF3F4F6)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowItem('Store name', 'ISMMART'),
                      rowItem(
                        'Store Slug',
                        '/ismmartshop',
                      ),
                      rowItem(
                        'Store Type',
                        'Home Decor',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * .8,
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Info',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.09,
                    letterSpacing: 0.30,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 250,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFF3F4F6)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowItem(
                        'Country',
                        'Pakistan',
                      ),
                      rowItem(
                        'City',
                        'Islamabad',
                      ),
                      rowItem(
                        'Address',
                        '22501, G-8/1 Islamabad',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          customBtn2(),
        ],
      ),
    ));
  }

  Widget titleAndBackBtn() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Store',
                style: newFontStyleSize20DM,
              ),
            ),
            CustomBackButton(onTap: () {
              Get.back();
            }),
          ],
        ),
      ),
    );
  }

  Widget rowItem(String key, String value) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            key,
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.11,
              letterSpacing: 0.30,
            ),
          ),
          const SizedBox(width: 30),
          Text(
            value,
            maxLines: 3,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF3669C9),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0.11,
              letterSpacing: 0.30,
            ),
          ),
        ],
      ),
    );
  }

  Widget customBtn2() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 40, left: 25, right: 25),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? const CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                backgroundColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit',
                      style: newFontStyleSize14.copyWith(
                          fontWeight: FontWeight.w700, color: newColorBlue),
                    ),
                  ],
                ),
                onPressed: () {
                  Get.to(StoreEditView());
                }),
      ),
    );
  }
}
