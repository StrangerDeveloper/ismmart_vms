import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/constants.dart';

class CustomTextField1 extends StatelessWidget {
  final String? title;
  final String? hint, labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final bool asterisk;
  final bool? showCursor;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Color fillColor;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final double prefixIconSize;
  final double suffixIconSize;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;

  const CustomTextField1({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 13.5,
    ),
    this.asterisk = false,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.autoValidateMode,
    this.title,
    this.hint,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onTap,
    this.minLines,
    this.showCursor,
    this.suffixIcon,
    this.prefixIconSize = 18,
    this.suffixIconSize = 18,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.errorText,
    this.readOnly = false,
    this.labelText,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      //fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      (asterisk)
                          ? const TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            )
                          : const TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        TextFormField(
          onChanged: onChanged,
          showCursor: showCursor,
          readOnly: readOnly,
          autovalidateMode: autoValidateMode,
          obscureText: obscureText,
          validator: validator,
          onTap: onTap,
          // style: bodyText1,
          // cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            suffixIcon: suffixIcon,
            //fillColor: fillColor,
            //filled: true,
            labelText: labelText,
            labelStyle: textStyle,
            hintText: hint,
            isDense: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1),
            ),
            hintStyle: const TextStyle(color: Colors.black45),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String? title;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool readOnly;
  final bool? showCursor;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  CustomTextField2({
    Key? key,
    this.showCursor,
    this.readOnly = false,
    this.fillColor,
    this.onChanged,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.label,
    this.title,
    this.autoValidateMode,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              title!,
              style: TextStyle(fontSize: 15),
            ),
          ),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          autovalidateMode: autoValidateMode,
          showCursor: showCursor,
          readOnly: readOnly,
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.lato(
              fontSize: 14,
              color: Colors.black54,
            ),
            floatingLabelStyle: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            // hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.green),
            // prefixIcon: prefixIcon,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: kPrimaryColor,
                    size: 22,
                  )
                : null,
            contentPadding: contentPadding,
            suffixIcon: suffixIcon,

            // suffixIconConstraints: BoxConstraints.expand(width: 40),
            filled: true,
            fillColor: Colors.white,
            // hintText: hintText,
            errorStyle: GoogleFonts.lato(
              color: Colors.red,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.8),
              borderRadius: BorderRadius.circular(9),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.1),
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
        ),
      ],
    );
  }
}

//
class CustomTextField3 extends StatelessWidget {
  final String? title;
  final String? hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool? showCursor;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool required;
  final bool enabled;

  CustomTextField3({
    Key? key,
    this.showCursor,
    this.readOnly = false,
    this.onChanged,
    this.contentPadding = EdgeInsets.zero,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.title,
    this.autoValidateMode,
    this.validator,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: RichText(
              text: TextSpan(
                text: title!,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: newColorDarkBlack2,
                ),
                children: [
                  if (required)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    )
                ],
              ),
            ),
          ),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          autovalidateMode: autoValidateMode,
          showCursor: showCursor,
          enabled: enabled,
          readOnly: readOnly,
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          // style: newFontStyle0.copyWith(
          //   color: newColorDarkBlack2,
          // ),
          obscuringCharacter: '●',
          decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: newFontStyle0.copyWith(
            //   color: newColorLightGrey2,
            // ),
            contentPadding: const EdgeInsets.only(top: 8, bottom: 10),
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints.tight(const Size(40, 25)),
            errorStyle: GoogleFonts.dmSans(
              fontSize: 13,
              color: Colors.red.shade700,
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEEEEEE)),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEEEEEE)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff929AAB)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 0.3),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
//
// class CountryCodePickerTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final String? initialValue;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autoValidateMode;
//   final ValueChanged<CountryCode>? onChanged;
//   final ValueChanged<String>? onPhoneFieldChange;
//   final bool? showCursor;
//   final bool readOnly;
//   final bool enabled;
//   final String? labelText, errorText;
//   final TextStyle? textStyle;
//   final List<TextInputFormatter>? inputFormatters;
//
//   CountryCodePickerTextField({
//     this.validator,
//     this.autoValidateMode,
//     this.controller,
//     this.initialValue,
//     this.keyboardType,
//     this.onChanged,
//     this.showCursor,
//     this.readOnly = false,
//     this.enabled = true,
//     this.inputFormatters,
//     this.errorText,
//     this.onPhoneFieldChange,
//     this.labelText,
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       inputFormatters: inputFormatters,
//       showCursor: showCursor,
//       readOnly: readOnly,
//       autovalidateMode: autoValidateMode,
//       validator: validator,
//       onChanged: onPhoneFieldChange,
//       decoration: InputDecoration(
//         errorText: errorText,
//         fillColor: Colors.white,
//         labelText: labelText,
//         labelStyle: textStyle,
//         prefixIcon: Container(
//           margin: EdgeInsets.fromLTRB(1, 1, 10, 1),
//           decoration: BoxDecoration(
//             border: Border(right: BorderSide(width: 1)),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(6),
//                 bottomLeft: Radius.circular(6),
//               ),
//             ),
//             child: CountryCodePicker(
//               flagDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(1),
//               ),
//               searchDecoration: InputDecoration(
//                 prefixIconColor: Colors.black,
//                 contentPadding: EdgeInsets.zero,
//                 labelText: labelText,
//                 labelStyle: textStyle,
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                     width: 1,
//                     style: BorderStyle.solid,
//                   ), //B
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black,
//                     width: 1,
//                     style: BorderStyle.solid,
//                   ), //B
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               textStyle: TextStyle(color: Colors.black),
//               enabled: enabled,
//               onChanged: onChanged,
//               // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//               initialSelection: initialValue,
//               favorite: ['+92'],
//             ),
//           ),
//         ),
//         contentPadding: EdgeInsets.fromLTRB(0, 12, 6.5, 12),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 1,
//             style: BorderStyle.solid,
//           ), //B
//           borderRadius: BorderRadius.circular(8),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 1,
//             style: BorderStyle.solid,
//           ), //B
//           borderRadius: BorderRadius.circular(8),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red.shade700, width: 1),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       controller: controller,
//       keyboardType: keyboardType,
//     );
//   }
// }
//
// class CountryCodePickerTextField2 extends StatelessWidget {
//   final String? title;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final String? initialValue;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autoValidateMode;
//   final ValueChanged<CountryCode>? onChanged;
//   final ValueChanged<String>? onPhoneFieldChange;
//   final bool? showCursor;
//   final bool readOnly;
//   final bool enabled;
//   final bool required;
//   final String? errorText;
//   final TextStyle? textStyle;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? hintText;
//
//   CountryCodePickerTextField2({
//     this.validator,
//     this.autoValidateMode,
//     this.controller,
//     this.initialValue,
//     this.keyboardType,
//     this.onChanged,
//     this.showCursor,
//     this.readOnly = false,
//     this.enabled = true,
//     this.inputFormatters,
//     this.errorText,
//     this.onPhoneFieldChange,
//     this.textStyle,
//     this.title,
//     this.hintText,
//     this.required = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 3),
//             child: RichText(
//               text: TextSpan(
//                 text: title!,
//                 style: GoogleFonts.dmSans(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: newColorDarkBlack2,
//                 ),
//                 children: [
//                   if (required)
//                     TextSpan(
//                       text: ' *',
//                       style: TextStyle(color: Colors.red),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         TextFormField(
//           inputFormatters: inputFormatters,
//           showCursor: showCursor,
//           readOnly: readOnly,
//           autovalidateMode: autoValidateMode,
//           validator: validator,
//           onChanged: onPhoneFieldChange,
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: newFontStyle0.copyWith(
//               color: newColorLightGrey2,
//             ),
//             errorText: errorText,
//             prefixIconConstraints: BoxConstraints.tight(Size(120, 50)),
//             prefixIcon: Row(
//               children: [
//                 CountryCodePicker(
//                   padding: EdgeInsets.zero,
//                   flagDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(1),
//                   ),
//                   searchDecoration: InputDecoration(
//                     contentPadding: EdgeInsets.zero,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                         style: BorderStyle.solid,
//                       ), //B
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                         style: BorderStyle.solid,
//                       ), //B
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   textStyle: newFontStyle0.copyWith(
//                     color: newColorDarkBlack2,
//                   ),
//                   enabled: enabled,
//                   onChanged: onChanged,
//                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                   initialSelection: initialValue,
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_sharp,
//                   size: 16,
//                   color: newColorLightGrey2,
//                 ),
//               ],
//             ),
//             contentPadding: EdgeInsets.only(top: 16),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffEEEEEE)),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xff929AAB)),
//             ),
//             errorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 0.3),
//             ),
//             focusedErrorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 0.6),
//             ),
//             errorStyle: GoogleFonts.dmSans(
//               fontSize: 13,
//               color: Colors.red.shade700,
//             ),
//           ),
//           controller: controller,
//           keyboardType: keyboardType,
//         ),
//       ],
//     );
//   }
// }
//
// class FormInputFieldWithIcon extends StatelessWidget {
//   const FormInputFieldWithIcon({
//     Key? key,
//     required this.controller,
//     this.iconPrefix,
//     this.labelText,
//     this.hintText,
//     this.suffix,
//     this.iconColor,
//     this.textStyle,
//     this.validator,
//     this.keyboardType = TextInputType.text,
//     this.minLines = 1,
//     this.maxLines = 1,
//     this.isExpanded = false,
//     this.maxLength,
//     this.autofocus,
//     this.enableBorder,
//     this.textCapitalization = TextCapitalization.none,
//     this.maxLengthEnforcement,
//     required this.onChanged,
//     required this.onSaved,
//     this.autoValidateMode,
//     this.inputFormatters,
//   }) : super(key: key);
//   final AutovalidateMode? autoValidateMode;
//   final TextEditingController controller;
//   final IconData? iconPrefix;
//   final String? labelText, hintText;
//   final bool? autofocus;
//   final Widget? suffix;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final int minLines;
//   final int? maxLines;
//   final bool? isExpanded;
//   final Color? iconColor;
//   final TextStyle? textStyle;
//   final int? maxLength;
//   final MaxLengthEnforcement? maxLengthEnforcement;
//   final InputBorder? enableBorder;
//   final TextCapitalization? textCapitalization;
//   final void Function(String) onChanged;
//   final void Function(String?)? onSaved;
//   final List<TextInputFormatter>? inputFormatters;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       autofocus: autofocus!,
//       textCapitalization: textCapitalization!,
//       textAlignVertical: TextAlignVertical.top,
//       autovalidateMode: autoValidateMode,
//       inputFormatters: inputFormatters,
//       scrollPhysics: const AlwaysScrollableScrollPhysics(),
//       //textAlign: TextAlign.center,
//       decoration: InputDecoration(
//         filled: false,
//         suffix: suffix,
//         prefixIcon: iconPrefix == null
//             ? null
//             : Icon(
//                 iconPrefix,
//                 color: kPrimaryColor,
//               ),
//         labelText: labelText,
//         labelStyle: textStyle,
//         hintText: hintText,
//         errorMaxLines: 2,
//         focusedBorder: enableBorder ??
//             OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.black, width: 1, style: BorderStyle.solid), //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//         border: enableBorder ??
//             OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.black, width: 1, style: BorderStyle.solid), //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//       ),
//       controller: controller,
//       cursorColor: iconColor,
//       style: textStyle,
//       onSaved: onSaved,
//       onChanged: onChanged,
//       keyboardType: keyboardType,
//       expands: isExpanded!,
//       maxLines: isExpanded! ? null : maxLines,
//       minLines: isExpanded! ? null : minLines,
//       maxLengthEnforcement: maxLengthEnforcement,
//       maxLength: maxLength,
//       validator: validator,
//     );
//   }
// }
//
// class FormPasswordInputFieldWithIcon extends StatefulWidget {
//   const FormPasswordInputFieldWithIcon(
//       {Key? key,
//       required this.controller,
//       this.iconPrefix,
//       required this.labelText,
//       required this.validator,
//       this.iconColor,
//       this.textStyle,
//       this.keyboardType = TextInputType.text,
//       this.obscureText = false,
//       this.minLines = 1,
//       this.maxLines,
//       this.maxLength,
//       this.maxLengthEnforcement,
//       this.onPasswordVisible,
//       required this.onChanged,
//       this.onSaved,
//       this.autoValidateMode})
//       : super(key: key);
//   final AutovalidateMode? autoValidateMode;
//   final TextEditingController controller;
//   final IconData? iconPrefix;
//   final String labelText;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final bool? obscureText;
//   final int minLines;
//   final int? maxLines;
//   final Color? iconColor;
//   final TextStyle? textStyle;
//   final int? maxLength;
//   final MaxLengthEnforcement? maxLengthEnforcement;
//   final void Function(String) onChanged;
//   final void Function(String?)? onSaved;
//   final void Function(bool?)? onPasswordVisible;
//
//   @override
//   State<FormPasswordInputFieldWithIcon> createState() =>
//       _FormPasswordInputFieldWithIconState();
// }
//
// class _FormPasswordInputFieldWithIconState
//     extends State<FormPasswordInputFieldWithIcon> {
//   RxBool passVisibility = true.obs;
//
//   _toggle() {
//     passVisibility.value = !passVisibility.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => TextFormField(
//         autovalidateMode: widget.autoValidateMode,
//         decoration: InputDecoration(
//             filled: false,
//             prefixIcon: widget.iconPrefix == null
//                 ? null
//                 : Icon(
//                     widget.iconPrefix,
//                     color: kPrimaryColor,
//                   ),
//             // enabledBorder: OutlineInputBorder(
//             //   //borderRadius: BorderRadius.circular(10),
//             //   borderSide: BorderSide(
//             //       color: Colors.black, width: 1, style: BorderStyle.solid), //B
//             //   borderRadius: BorderRadius.circular(8),
//             // ),
//             fillColor: widget.iconColor ?? kPrimaryColor,
//             labelText: widget.labelText,
//             labelStyle: widget.textStyle,
//             focusColor: widget.iconColor,
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.black, width: 1, style: BorderStyle.solid),
//               //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.black, width: 1, style: BorderStyle.solid),
//               //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//             suffixIcon: widget.obscureText!
//                 ? GestureDetector(
//                     onTap: _toggle,
//                     child: Icon(
//                       passVisibility.isTrue
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: Colors.black87,
//                     ),
//                   )
//                 : null),
//         controller: widget.controller,
//         cursorColor: widget.iconColor,
//         onSaved: widget.onSaved,
//         onChanged: widget.onChanged,
//         keyboardType: widget.keyboardType,
//         obscureText: passVisibility.value,
//         style: widget.textStyle,
//         maxLines: widget.maxLines,
//         minLines: widget.minLines,
//         maxLengthEnforcement: widget.maxLengthEnforcement,
//         maxLength: widget.maxLength,
//         validator: widget.validator,
//       ),
//     );
//   }
// }
