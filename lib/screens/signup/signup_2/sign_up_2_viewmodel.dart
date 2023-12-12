import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/category_model.dart';
import 'package:ismmart_vms/models/subcategory_model.dart';
import '../../../helper/global_variables.dart';
import '../../../widgets/pick_image.dart';

class SignUp2ViewModel extends GetxController{

  GlobalKey<FormState> vendorSignUp2FormKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController storeSlugController = TextEditingController();
  RxString shopLogoImage = ''.obs;
  RxBool shopImageErrorVisibility = false.obs;
  RxInt cityId = 0.obs;
  RxInt countryId = 0.obs;
  RxList<int> storeTypeList = <int>[].obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
  RxBool storeTypeErrorVisibility = false.obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  @override
  void onInit() async{
    fillListWithDummyData();
    super.onInit();
  }

  fillListWithDummyData() {
    categoriesList.addAll({
      CategoryModel(
        id: 1,
        name: 'Select Category ...',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        image: '',
        isPressed: false,
      ),
      CategoryModel(
          id: 2,
          name: 'Category 1',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          image: '',
          isPressed: false,
          subCategories: [
            SubCategory(
              id: 1,
              name: 'SubCategory 2 - 1',
              categoryId: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            SubCategory(
              id: 2,
              name: 'SubCategory 2 - 2',
              categoryId: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )
          ]),
      CategoryModel(
          id: 3,
          name: 'Category 2',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          image: '',
          isPressed: false,
          subCategories: [
            SubCategory(
              id: 3,
              name: 'SubCategory 3 - 1',
              categoryId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            SubCategory(
              id: 3,
              name: 'SubCategory 3 - 2',
              categoryId: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            SubCategory(
              id: 3,
              name: 'SubCategory 3 - 3',
              categoryId: 3,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ]),
    });
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar)async{
    final image = await PickImage().pickSingleImage();
    if(image != null){
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  Future<void> proceed() async{
    if (vendorSignUp2FormKey.currentState?.validate() ?? false) {
      if(checkDropDowns() == true){

          GlobalVariable.showLoader.value = false;

          Map<String, String> details = {
            "storeName": storeNameController.text,
            // "type": "${shopCategoryId.value}",
            "country": "${countryId.value}",
            "city": "${cityId.value}",
            'storeImage': shopLogoImage.value,
            'address': storeAddressController.text,
          };

          // Get.toNamed(Routes.vendorSignUp3, arguments: {
          //   'shopDetails': details
          // });
      }
    } else{
      // checkImages();
      checkDropDowns();
    }
  }

  checkDropDowns(){
    bool proceed1 = true;
    if(countryId.value == 0){
      countryErrorVisibility.value = true;
      proceed1 = false;
    }
    if(cityId.value == 0){
      cityErrorVisibility.value = true;
      proceed1 = false;
    }
    if(storeTypeList.isEmpty){
      storeTypeErrorVisibility.value = true;
      proceed1 = false;
    }
    return proceed1;
  }

  // bool checkImages(){
  //   bool proceed2 = true;
  //   if(cnicFrontImage.value == ''){
  //     cnicFrontErrorVisibility.value = true;
  //     proceed2 = false;
  //   }
  //   if(cnicBackImage.value == ''){
  //     cnicBackErrorVisibility.value = true;
  //     proceed2 = false;
  //   }
  //   if(shopLogoImage.value == ''){
  //     shopImageErrorVisibility.value = true;
  //     proceed2 = false;
  //   }
  //   return proceed2;
  // }
}