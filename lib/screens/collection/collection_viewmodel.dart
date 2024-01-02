import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/api_base_helper.dart';
import 'package:ismmart_vms/helper/urls.dart';
import 'package:ismmart_vms/screens/collection/collection_model.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../helper/global_variables.dart';
import '../../widgets/pick_image.dart';

class CollectionViewModel extends GetxController {
  TextEditingController titleController = TextEditingController();

  @override
  void onInit() {
    GlobalVariable.showLoader.value = false;
    getCollection();
    publishingSelectedList.clear();
    // TODO: implement onInit
    super.onInit();
  }

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

  //-----     Get All Collection    ----------
  RxList<CollectionModel> collectionList = <CollectionModel>[].obs;
  Future<void> getCollection() async {
    try {
      var parsedJson = await ApiBaseHelper().getMethod(url: Urls.collection);

      if (parsedJson['success'] == true) {
        var data = parsedJson['data']['items'] as List;
        collectionList.addAll(data.map((e) => CollectionModel.fromJson(e)));
        print(collectionList[0].sId);
      }
    } catch (e) {
      print(e);
    }
  }
}
