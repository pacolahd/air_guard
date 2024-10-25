import 'package:air_guard/core/common/widgets/custom_form_builder_text_field.dart';
import 'package:air_guard/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomFormBuilderTitledTextField extends StatelessWidget {
  const CustomFormBuilderTitledTextField({
    required this.title,
    required this.name,
    this.required = true,
    this.border,
    this.controller,
    this.filled = true,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validators,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.onTap,
    this.focusNode,
    this.enabled,
    this.maxLines = 1,
    this.contentPadding,
    this.onChanged,
    this.additionalTapOutside,
    this.isRepeatPassword,
  });

  final bool required;
  final String title;
  final String name;
  final bool? enabled;
  final InputBorder? border;
  final List<String? Function(String?)>? validators;
  final TextEditingController? controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String?)? onChanged;
  final void Function()? additionalTapOutside;
  final bool? isRepeatPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: context.theme.textTheme.titleSmall,
                children: required || isRepeatPassword == true
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                      ]
                    : null,
              ),
            ),
            // if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 8),
        CustomFormBuilderTextField(
          additionalTapOutside: additionalTapOutside,
          onChanged: onChanged ?? (_) {},
          suffixIcon: suffixIcon,
          maxLines: maxLines,
          name: name,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          validator: FormBuilderValidators.compose([
            if (required)
              (value) {
                if (value == null || value.isEmpty) {
                  return '$title is required';
                }
                return null;
              },
            if (validators != null) ...validators!,
          ]),
          overrideValidator: true,
          filled: filled,
          fillColour: fillColour,
          border: border,
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onTap: onTap,
          focusNode: focusNode,
          enabled: enabled,
          contentPadding: contentPadding,
        ),
      ],
    );
  }
}
