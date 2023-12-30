import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../helper/global_variables.dart';
import '../../widgets/pick_image.dart';

class CollectionViewModel extends GetxController {
  @override
  void onInit() {
    GlobalVariable.showLoader.value = false;
    publishingSelectedList.clear();
    // TODO: implement onInit
    super.onInit();
  }

  TextEditingController titleController = TextEditingController();

  //---------Image Data---------
  RxString collectionImage = ''.obs;
  RxBool collectionImageErrorVisibility = false.obs;

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  //------Tool Bar Setting Data------
  QuillEditorController prodDescriptionController = QuillEditorController();

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  //------------- Radio Button Data
  RxString radioBtn = 'manual'.obs;

  //-----MultiSelect Data--------
  RxList<int> publishingSelectedList = <int>[].obs;
  RxList<String> publishingList = [
    'Online Store',
    'Buy Button',
    'Point of Sale',
    'Multi Vendor Dashboard Admin',
    'ShopShop has noticed your store doesn\'t meet shopping requirements.\n',
    'Facebook & Instagram',
  ].obs;
}
