import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:link_go/utils/app_colors.dart';
import 'package:link_go/utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hint;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final dynamic validator;
  final bool? obscure;
  final bool? enable;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color;
  final double? borderRadius;
  final String? prefixText;
  final Widget? prefixIcon;
  final Function()? onTap;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.hint,
    this.label,
    this.maxLength,
    this.maxLines,
    this.validator,
    this.obscure = false,
    this.enable = true,
    this.inputType,
    this.controller,
    this.onTap,
    this.suffixIcon,
    this.inputFormatters,
    this.color = AppColors.white, this.borderRadius,
    this.prefixText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: onTap,
      inputFormatters: inputFormatters,
      obscureText: obscure!,
      validator: validator != null ? validator : null,
      maxLength: maxLength != null ? maxLength : null,
      maxLines: maxLines != null ? maxLines : null,
      controller: controller,
      enabled: enable!,
      onChanged: (v) {
        if (onChanged != null) {
          onChanged!(v);
        }
      },
      keyboardType: inputType == null ? TextInputType.text : inputType,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade50,// color,
        filled: true,
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        suffixIcon: suffixIcon ?? null,
        hintStyle: GoogleFonts.roboto(
          fontSize: 14,
          color:  Color(0xff8391A1),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xff8391A1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: AppColors.black),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: AppColors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.black,
            width: 1.h,
          ),
        ),
        errorStyle: const TextStyle(color: AppColors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
