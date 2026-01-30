import 'package:cinema_db/theme_data/fonts.dart';
import 'package:cinema_db/theme_data/palette.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFieldComponent({
    super.key,
    this.hint,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: CustomFontStyle.regularText,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        hintStyle: CustomFontStyle.regularText.copyWith(
          color: Palette.greyColor.withValues(alpha: 0.6),
        ),
        fillColor: Palette.inputTextColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(color: Palette.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(color: Palette.borderColor, width: 1),
        ),
        contentPadding: EdgeInsets.only(
          right: 30,
          left: 30,
          top: 15,
          bottom: 15,
        ),
        isDense: true,
        prefixIconConstraints: BoxConstraints(maxHeight: 30),
        prefixIcon: prefixIcon,
        suffixIconConstraints: BoxConstraints(maxHeight: 30),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
