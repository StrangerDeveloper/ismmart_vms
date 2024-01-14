import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';
import 'package:ismmart_vms/helper/utils/size_utils.dart';

import '../../widgets/custom_appbar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar2(
          title: 'Notifications',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: ListView.builder(
            itemBuilder: (context, int index) {
              return listItems();
            },
          ),
        ));
  }

  //----- items Widget-----
  Widget listItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "Today",
            style: newFontStyleSize16.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Row(
          children: [
            networkImage(),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  notificationText(),
                ],
              ),
            )
          ],
        ),
        divider(),
        Row(
          children: [
            networkImage(),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [notificationText2()],
              ),
            )
          ],
        ),
        divider(),

        //-------yesterday static-------
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "Yesterday",
            style: newFontStyleSize16.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Row(
          children: [
            networkImage(),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [notificationText3()],
              ),
            )
          ],
        ),
        divider(),
        Row(
          children: [
            networkImage(),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [notificationText3()],
              ),
            )
          ],
        ),
        divider(),
      ],
    );
  }

  Widget networkImage() {
    return CachedNetworkImage(
      height: 44.v,
      width: 44.h,
      imageUrl:
          'https://unsplash.com/photos/man-standing-beside-wall-pAtA8xe_iVM',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/logo/logo_new.png'),
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
    );
  }

  Widget notificationText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {},
        child: Center(
          child: RichText(
            textAlign: TextAlign.start,
            maxLines: 6,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "New Order from",
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey5)),
                TextSpan(
                    text: " Jese Leos: \n",
                    style: newFontStyleSize14.copyWith(
                        color: ThemeHelper.darkblue,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: ' "SKU:90121". \n',
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey5)),
                TextSpan(
                    text: ' a few moments ago ',
                    style: newFontStyleSize12.copyWith(color: newColorBlue5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationText2() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          width: Get.size.width * .7,
          child: RichText(
            textAlign: TextAlign.start,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                    text: " Jese Leos: ",
                    style: newFontStyleSize14.copyWith(
                        color: ThemeHelper.darkblue,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: "Order (#1234) has been canceled. \n",
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey5)),
                TextSpan(
                    text: ' 10 moments ago ',
                    style: newFontStyleSize12.copyWith(color: newColorBlue5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationText3() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {},
        child: SizedBox(
          width: Get.size.width * .7,
          child: RichText(
            textAlign: TextAlign.start,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                    text: " Jese Leos: ",
                    style: newFontStyleSize14.copyWith(
                        color: ThemeHelper.darkblue,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: "Order (#1234) has been canceled. \n",
                    style:
                        newFontStyleSize14.copyWith(color: newColorLightGrey5)),
                TextSpan(
                    text: 'Yesterday   02:15 PM',
                    style: newFontStyleSize12.copyWith(color: newColorBlue5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---Divider-----
  Widget divider() {
    return const Divider(
      color: Color(0xffEEEEEE),
      thickness: 1,
      height: 20,
    );
  }
}
