import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final bool autofocus;
  const CommonTextField({
    super.key,
    required this.controller,
    this.hintText = 'Input something here...',
    this.prefixIcon,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      style: context.theme.textTheme.titleSmall,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        hintStyle: context.theme.textTheme.titleSmall?.copyWith(
          color: context.theme.colorScheme.onBackground.withOpacity(0.5),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        fillColor: context.theme.colorScheme.surfaceVariant,
        filled: true,
      ),
    );
  }
}
