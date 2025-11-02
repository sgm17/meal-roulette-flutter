import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.node,
      this.enabled,
      this.errorText,
      this.autoFocus,
      this.prefixIcon,
      this.onChangeFtn,
      this.initialValue,
      this.validatorFtn,
      this.textAlignment,
      required this.name,
      required this.hint,
      this.isPass = false,
      this.textCapitalization = TextCapitalization.none,
      this.isSuffixIcon = false,
      required this.textInputType,
      this.width = double.infinity,
      this.textInputAction = TextInputAction.done,
      this.readOnly,
      this.onTap,
      this.maxLines,
      this.textController,
      this.onSubmitFtn,
      this.helperText,
      this.helperStyle,
      this.suffixIcon,
      this.show = false,
      this.borderColor,
      this.onTapEye});

  final String name;
  final int? maxLines;
  final TextEditingController? textController;
  final String? hint, helperText, errorText, initialValue;
  final TextStyle? helperStyle;
  final bool? isPass, show, readOnly, enabled, autoFocus, isSuffixIcon;
  final double? width;
  final FocusNode? node;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap, onTapEye;
  final TextAlign? textAlignment;
  final Color? borderColor;

  final String? Function(String?)? validatorFtn;
  final String? Function(String?)? onChangeFtn;
  final String? Function(String?)? onSubmitFtn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return FormBuilderTextField(
        textAlign: textAlignment ?? TextAlign.start,
        cursorColor: R.colors.secondaryColor,
        style: R.textStyles.font16R.copyWith(color: R.colors.black),
        autocorrect: false,
        controller: textController,
        onTap: onTap,
        textCapitalization: textCapitalization,
        enabled: enabled ?? true,
        initialValue: initialValue,
        name: name,
        autofocus: autoFocus ?? false,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        focusNode: node,
        readOnly: readOnly ?? false,
        obscureText: show ?? false,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          filled: true,
          focusColor: R.colors.veryLightGrey,
          fillColor: R.colors.veryLightGrey,
          hoverColor: R.colors.veryLightGrey,
          helperMaxLines: 2,
          helperStyle: helperStyle,
          helperText: helperText,
          errorText: errorText,
          suffixIcon: isPass!
              ? IconButton(
                  splashRadius: 8,
                  onPressed: onTapEye,
                  icon: Icon(
                    show! ? Icons.visibility_off : Icons.visibility,
                    size: 20.sp,
                    color: R.colors.primaryColor,
                  ),
                )
              : suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h).copyWith(left: 25.w),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 18.sp, color: R.colors.lightGreyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              color: borderColor != null ? borderColor ?? R.colors.primaryColor : R.colors.veryLightGrey,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.sp), borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25.sp), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25.sp), borderSide: BorderSide(color: R.colors.primaryColor, width: 1.5)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25.sp), borderSide: BorderSide.none),
        ),
        validator: validatorFtn,
        onChanged: onChangeFtn,
        onSubmitted: onSubmitFtn,
      );
    });
  }
}
