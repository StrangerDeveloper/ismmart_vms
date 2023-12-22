import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_vms/helper/constants.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class CustomDropDownList1 extends StatelessWidget {
  final String? title;
  final bool asterisk;
  final RxString value;
  final String? hintText;
  final ValueChanged? onChanged;
  final List<DropDownModel> dropdownList;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropDownList1({
    super.key,
    this.title,
    required this.value,
    this.hintText,
    required this.onChanged,
    required this.dropdownList,
    this.asterisk = false,
    this.validator,
    this.autoValidateMode,
    this.labelText,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 1),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                    children: [
                      (asterisk)
                          ? const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            )
                          : const TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        Obx(
          () => DropdownButtonFormField(
            //dropdownColor: context.isDarkMode ? ThemeColors.dark2 : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: kContainerFillColor,
              hintText: hintText,
              hintStyle: GoogleFonts.dmSans(
                color: newColorLightGrey2,
                fontWeight: FontWeight.w400
              ),
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kTextfieldBorderColor, width: 0.8),
                borderRadius: BorderRadius.circular(9),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kTextfieldBorderColor, width: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700, width: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            autovalidateMode: autoValidateMode,
            validator: validator,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 25,
            value: value.value,
            isExpanded: true,
            onChanged: onChanged,
            items: dropdownList.map(
              (DropDownModel dropDownItem) {
                return DropdownMenuItem<String>(
                  value: dropDownItem.id,
                  child: Text(dropDownItem.name ?? 'N/A',
                    style: GoogleFonts.dmSans(
                      color: dropDownItem.id == '1' ? newColorLightGrey2 : Colors.black,
                      fontWeight: dropDownItem.id == '1' ? FontWeight.w400 : FontWeight.w500,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

//make this dropDown if required...
// class CustomDropDownList2 extends StatelessWidget {
//   final String? title;
//   final bool asterisk;
//   final RxString value;
//   final ValueChanged? onChanged;
//   final List<DropDownModel> list;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autoValidateMode;
//   final String? labelText;
//   final EdgeInsetsGeometry? contentPadding;
//
//   const CustomDropDownList2({super.key,
//     this.title,
//     required this.value,
//     required this.onChanged,
//     required this.list,
//     this.asterisk = false,
//     this.validator,
//     this.autoValidateMode,
//     this.labelText,
//     this.contentPadding = const EdgeInsets.fromLTRB(10, 8.5, 10, 8.5),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         (title == null)
//             ? Container()
//             : Padding(
//           padding: const EdgeInsets.only(bottom: 6, left: 1),
//           child: RichText(
//             text: TextSpan(
//               text: title,
//               style: TextStyle(
//                 // color: context.isDarkMode
//                 //     ? ThemeColors.dark3
//                 //     : ThemeColors.brown2,
//                 fontSize: 12.5,
//               ),
//               children: [
//                 (asterisk)
//                     ? TextSpan(
//                   text: ' *',
//                   style: TextStyle(color: Colors.red, fontSize: 13),
//                 )
//                     : TextSpan(text: '')
//               ],
//             ),
//           ),
//         ),
//         Obx(
//               () => DropdownButtonFormField(
//             //dropdownColor: context.isDarkMode ? ThemeColors.dark2 : null,
//             decoration: InputDecoration(
//               contentPadding: contentPadding,
//             ),
//             autovalidateMode: autoValidateMode,
//             validator: validator,
//             iconSize: 20,
//             value: value.value,
//             isExpanded: true,
//             onChanged: onChanged,
//             items: list.map(
//                   (DropDownModel dropDownItem) {
//                 return DropdownMenuItem<String>(
//                   value: dropDownItem.id,
//                   child: Text(dropDownItem.name!),
//                 );
//               },
//             ).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
