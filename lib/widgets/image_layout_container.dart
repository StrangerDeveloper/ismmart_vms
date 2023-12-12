import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';

class ImageLayoutContainer extends StatelessWidget {
  ImageLayoutContainer({
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    if(required)
                      TextSpan(
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
                    style: TextStyle(
                      color: ThemeHelper.fadedBlue,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                'Image should be less than 2 MB',
                style: TextStyle(
                  color: ThemeHelper.fadedBlue,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Text(
                  'Choose File',
                  style: TextStyle(
                    color: ThemeHelper.plattet1.shade900,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                filePath == '' ? "No File Chosen" : filePath,
                style: TextStyle(
                  color: ThemeHelper.fadedBlue,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Divider(
            color: Color(0xffEEEEEE),
            thickness: 1,
            height: 20,
          ),
          if(description)
            Text(
              "This cheque image should have the same bank details visible as you mentioned above",
              style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: ThemeHelper.lightGrey
              ),
            ),
          Visibility(
            visible: errorVisibility,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorPrompt,
                style: GoogleFonts.dmSans(
                    color: Colors.red.shade700,
                    fontSize: 12
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}