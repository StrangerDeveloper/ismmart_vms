import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/api_base_helper.dart';
import '../../../../helper/urls.dart';
import '../../../../widgets/pick_image.dart';
import 'package:ismmart_vms/models/bank_details_model.dart';

import '../signup_1/sign_up_1_viewmodel.dart';
import '../signup_2/sign_up_2_viewmodel.dart';
import '../signup_4/sign_up_4_view.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SignUp3ViewModel extends GetxController {
  GlobalKey<FormState> vendorSignUp3FormKey = GlobalKey<FormState>();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankAccTitleController = TextEditingController();
  TextEditingController bankAccNumberController = TextEditingController();
  TextEditingController bankIBANController = TextEditingController();
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
    getBankList();
    super.onInit();
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  Map<String, String> param = {};
  Future<void> signUp3Btn() async {
    print(bankNameController.text);
    if (vendorSignUp3FormKey.currentState!.validate()) {
      param = Get.arguments;
      // GlobalVariable.showLoader.value = true;
      param['banks[0][name]'] = bankController.text;
      param['banks[0][title]'] = bankAccTitleController.text;
      param['banks[0][iban]'] = bankIBANController.text;
      param['banks[0][accountNumber]'] = bankAccNumberController.text;
      param['step'] = '3';
      var parseJson = await ApiBaseHelper().getMethod(url: Urls.bank);
      if (parseJson['success'] == true) {
        print("=======succcess ------- step 3");
        finalRegistration(param);
      }
    }
  }

  Future<void> finalRegistration(Map<String, String> param) async {
    print(param);
    final SignUpScreen1ViewModel viewModel1 = Get.put(SignUpScreen1ViewModel());
    final SignUp2ViewModel viewModel2 = Get.put(SignUp2ViewModel());
    param['step'] = '4';
    //print(param);

    //-------Images Files add of All signup Steps------------
    List<http.MultipartFile> fileList = [];

    fileList.add(
      await http.MultipartFile.fromPath(
        'cnicImages',
        viewModel1.cnicFrontImage.value,
        contentType: MediaType.parse('image/jpeg'),
      ),
    );
    fileList.add(
      await http.MultipartFile.fromPath(
        'cnicImages',
        viewModel1.cnicBackImage.value,
        contentType: MediaType.parse('image/jpeg'),
      ),
    );
    fileList.add(
      await http.MultipartFile.fromPath(
        'storeImage',
        viewModel2.shopLogoImage.value,
        contentType: MediaType.parse('image/jpeg'),
      ),
    );

    var parsedJson = await ApiBaseHelper()
        .postMethodForImage(url: Urls.register, files: fileList, fields: param);

    if (parsedJson['success'] == true) {
      print("=======succcess ------- step 4");
      Get.offAll(() => SignUp4View());
    }
  }

  //-----------------Bank Field Data------------
  TextEditingController bankController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> allBankist = [];
  List bankIdList = [];
  RxList<String> filteredBankList = <String>[].obs;

  Future<void> getBankList() async {
    filteredBankList.clear();
    allBankist.clear();
    var parseJson = await ApiBaseHelper().getMethod(url: Urls.bank);
    if (parseJson['success'] == true) {
      allBankist.clear();
      filteredBankList.clear();
      List rawList = parseJson['data']['items'];

      for (var e in rawList) {
        allBankist.add(e['name'].toString());
        bankIdList.add(e['_id'].toString());
      }

      //print country with Id for Test------
      //print(allBankist);
      //print(bankIdList);
    }
  }

  onSearch(String value) {
    filteredBankList.clear();
    filteredBankList.addAll(
        allBankist.where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  resetValue() {
    searchController.text = '';
    filteredBankList.clear();
    allBankist.clear();
    filteredBankList.addAll(allBankist);
  }
}
