import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/models/bank_details_model.dart';
import 'package:ismmart_vms/screens/signup/signup_4/sign_up_4_view.dart';
import '../../../widgets/pick_image.dart';

class SignUp3ViewModel extends GetxController {
  GlobalKey<FormState> vendorSignUp3FormKey = GlobalKey<FormState>();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccTitleController = TextEditingController();
  TextEditingController bankAccNumberController = TextEditingController();
  TextEditingController branchCodeController = TextEditingController();
  RxMap<String, String> params = <String, String>{}.obs;
  RxString bankChequeImage = ''.obs;
  RxBool chequeImageErrorVisibility = false.obs;
  RxBool enableBranchCode = false.obs;
  RxBool termAndCondition = false.obs;
  RxList<Widget> banksList = <Widget>[].obs;
  RxList<BankDetailsModel> banksDetails = <BankDetailsModel>[].obs;

  @override
  void onInit() {
    // params.value = Get.arguments['shopDetails'];
    super.onInit();
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  signUp() async {
    if (vendorSignUp3FormKey.currentState!.validate()) {
      // GlobalVariable.showLoader.value = true;
      params.addAll({
        'bankName': bankNameController.text,
        'accountTitle': bankAccTitleController.text,
        'accountNumber': bankAccNumberController.text,
        'membership': 'Free',
        'premium': 'false',
      });

      params.addIf(
          enableBranchCode.value, 'branchCode', branchCodeController.text);

      print(params);

      Get.offAll(() => SignUp4View());

      //   List<http.MultipartFile> fileList = [];
      //   fileList.add(
      //       await http.MultipartFile.fromPath(
      //           'cnicFront',
      //           params['cnicFront']!,
      //           contentType: MediaType.parse('image/jpeg')
      //       )
      //   );
      //   fileList.addAll({
      //     await http.MultipartFile.fromPath(
      //         'storeImage',
      //         params['storeImage']!,
      //         contentType: MediaType.parse('image/jpeg')
      //     ),
      //     await http.MultipartFile.fromPath(
      //         'cnicBack',
      //         params['cnicBack']!,
      //         contentType: MediaType.parse('image/jpeg')
      //     ),
      //     await http.MultipartFile.fromPath(
      //         'chequeImage',
      //         bankChequeImage.value,
      //         contentType: MediaType.parse('image/jpeg')
      //     )
      //   });
      //   ApiBaseHelper().postMethodForImage(
      //       url: 'auth/vendor/register',
      //       files: fileList,
      //       fields: params,
      //     withAuthorization: true
      //   ).then((parsedJson) async {
      //     GlobalVariable.showLoader.value = false;
      //     if(parsedJson['success'] == true){
      //       AppConstant.displaySnackBar(
      //       langKey.successTitle.tr,
      //         parsedJson['message']
      //       );
      //       int count = 0;
      //       Get.until((route) => count++ >= 2);
      //       Get.toNamed(Routes.vendorSignUp4, arguments: {
      //         'fromSettings': false
      //       });
      //     } else{
      //       AppConstant.displaySnackBar(
      //           langKey.errorTitle.tr,
      //           parsedJson['message']
      //       );
      //     }
      //   }).catchError((e){
      //     GlobalVariable.showLoader.value = false;
      //     AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      // //    GlobalVariable.internetErr(true);
      //   });
    }
  }
}