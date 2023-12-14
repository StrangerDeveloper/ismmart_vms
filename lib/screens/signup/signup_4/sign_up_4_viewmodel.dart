import 'package:get/get.dart';

class SignUp4ViewModel extends GetxController {

  RxBool fromSettings = false.obs;

  @override
  void onInit()async {
    fromSettings.value = Get.arguments['fromSettings'];
    await getCurrentUser();
    super.onInit();
  }

  Future<void> getCurrentUser() async {
    if (fromSettings.value == false) {
      // await ApiBaseHelper()
      //     .getMethod(url: 'user/profile', withAuthorization: true)
      //     .then((parsedJson) async {
      //   if (parsedJson['success'] is bool == true) {
      //     UserResponse userResponse = UserResponse.fromResponse(parsedJson);
      //     userResponse.userModel?.token = authController.userToken!;
      //     GlobalVariable.userModel = userResponse.userModel;
      //     SettingViewModel settingViewModel = Get.find();
      //     settingViewModel.setUserModel(userResponse.userModel);
      //     // AuthController authController = Get.find();
      //     // authController.setCurrUserToken(parsedJson['data']['token']);
      //     await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
      //         .then((value) {});
      //   }
      // });
    }
  }
}