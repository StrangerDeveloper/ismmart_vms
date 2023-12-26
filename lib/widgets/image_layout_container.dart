import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';

class ImageLayoutContainer extends StatelessWidget {
  const ImageLayoutContainer({
    super.key,
    required this.onTap,
    required this.title,
    this.subTitle,
    required this.filePath,
    this.required = true,
    this.errorPrompt = '',
    this.errorVisibility = false,
    this.description = false,
  });

  final void Function() onTap;
  final String title;
  final String? subTitle;
  final String filePath;
  final bool required;
  final String errorPrompt;
  final bool errorVisibility;
  final bool description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: newFontStyleSize14,
                  children: [
                    if (required)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    subTitle!,
                    style: const TextStyle(
                      color: ThemeHelper.fadedBlue,
                    ),
                  ),
                ),
              const Spacer(),
              const Text(
                'Image should be less than 2 MB',
                style: TextStyle(
                  color: ThemeHelper.fadedBlue,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  height: 37,
                  width: 115,
                  decoration: const BoxDecoration(
                      color: Color(0xFF929AAB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      )),
                  child: const Text(
                    'Choose File',
                    style: TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 17),
                width: 200,
                height: 37,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFEEEEEE),
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  filePath == '' ? 'No file chosen' : filePath,
                  style: const TextStyle(
                    color: Color(0xFF24272C),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                ),
              )
            ],
          ),

          // Divider(
          //   color: Color(0xffEEEEEE),
          //   thickness: 1,
          //   height: 20,
          // ),
          if (description)
            Text(
              "This cheque image should have the same bank details visible as you mentioned above",
              style: GoogleFonts.dmSans(
                  fontSize: 12, color: ThemeHelper.lightGrey),
            ),
          Visibility(
            visible: errorVisibility,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorPrompt,
                style: GoogleFonts.dmSans(
                    color: Colors.red.shade700, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
