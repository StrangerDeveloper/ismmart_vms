import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/custom_button.dart';

import '../helper/global_variables.dart';

class NoInternetView extends StatelessWidget {
  final VoidCallback? onPressed;

  const NoInternetView({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GlobalVariable.noInternet.isTrue)
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Get.isDarkMode ? Colors.black : Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/no_internet.svg', width: 250),
                  const SizedBox(height: 30),
                  const Text(
                    'No Internet connection',
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Text(
                      'Please check your internet connection\nand try again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode ? Colors.black38 : Colors.grey,
                      ),
                    ),
                  ),
                  CustomTextBtn(
                    onPressed: onPressed,
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

// Widget tryAgainBtn() {
//   return CustomTextBtn(
//     child: const Text("Try Again"),
//     // minimumSize: Size(200, 45),
//     // backgroundColor: ,
//     onPressed: onPressed,
//   );
// }
}
