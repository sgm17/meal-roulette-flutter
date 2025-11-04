import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';

/// Small stat card used in the dashboard row. Uses AnimatedContainer & AnimatedOpacity
/// to provide subtle motion on rebuilds and when pressed.
class ProfileTextField extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const ProfileTextField({super.key, required this.title,  required this.controller, required this.icon, required this.validator, required this.hint});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(widget.icon, size: 16.sp, color: R.colors.textBlack),
            SizedBox(width: 4.w),
            Text(
              widget.title,
              style: R.textStyles.font11M.copyWith(color: R.colors.textBlack),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        ),
        SizedBox(height: 4.h),
        // Editable Inputs
        TextFormField(
          autofocus: false,
          autovalidateMode: AutovalidateMode.onUnfocus,
          controller: widget.controller,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          enableSuggestions: true,
          maxLines: 1,
          style: R.textStyles.font11M,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: R.textStyles.font11R.copyWith(color: R.colors.textGrey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),
            filled: true,
            fillColor: R.colors.dividerBorderColor.withValues(alpha: 0.2),
            isDense: true, // ensures compact layout
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: R.colors.textGrey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(
                color: R.colors.red,
                width: 1.2,
              ),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
