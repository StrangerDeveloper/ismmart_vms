import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_vms/widgets/widget_models/dropdown_model.dart';

class CustomDropDownList1 extends StatelessWidget {
  final String? title;
  final bool asterisk;
  final RxString value;
  final ValueChanged? onChanged;
  final List<DropDownModel> list;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropDownList1({
    super.key,
    this.title,
    required this.value,
    required this.onChanged,
    required this.list,
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 0.8),
                borderRadius: BorderRadius.circular(9),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.1),
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
            iconSize: 20,
            value: value.value,
            isExpanded: true,
            onChanged: onChanged,
            items: list.map(
              (DropDownModel dropDownItem) {
                return DropdownMenuItem<String>(
                  value: dropDownItem.id,
                  child: Text(dropDownItem.name ?? 'N/A'),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
