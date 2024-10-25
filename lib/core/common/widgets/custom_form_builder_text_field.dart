import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormBuilderTextField extends StatelessWidget {
  const CustomFormBuilderTextField({
    required this.name,
    this.border,
    this.controller,
    this.filled = true,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
    this.onTap,
    this.focusNode,
    this.enabled,
    this.maxLines = 1,
    this.contentPadding,
    this.onChanged,
    this.additionalTapOutside,
  });

  final String name;
  final bool? enabled;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String?)? onChanged;
  final void Function()? additionalTapOutside;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      onChanged: onChanged ?? (_) {},
      enabled: enabled ?? true,
      name: name,
      style: context.theme.textTheme.bodyMedium,
      focusNode: focusNode,
      controller: controller,
      onTap: onTap,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        if (additionalTapOutside != null) {
          additionalTapOutside;
        }
      },
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: border ?? context.theme.inputDecorationTheme.border,
        enabledBorder:
            border ?? context.theme.inputDecorationTheme.enabledBorder,
        focusedBorder:
            border ?? context.theme.inputDecorationTheme.focusedBorder,
        errorBorder: border ?? context.theme.inputDecorationTheme.errorBorder,
        focusedErrorBorder:
            border ?? context.theme.inputDecorationTheme.focusedErrorBorder,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: filled,
        fillColor: fillColour ?? context.theme.inputDecorationTheme.fillColor,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? context.theme.inputDecorationTheme.hintStyle,
      ),
    );
  }
}
