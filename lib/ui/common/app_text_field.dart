import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final bool hideText;
  AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validate,
    this.hideText = false,
  });

  final _hideTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _hideTextNotifier,
      builder: (context, isHidden, child) {
        return TextFormField(
          controller: controller,
          validator: validate,
          obscureText: isHidden && hideText,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: label,
            suffixIcon: _buildSuffix(isHidden),
          ),
        );
      },
    );
  }

  Widget? _buildSuffix(bool isHidden) {
    if (hideText) {
      return InkWell(
        onTap: () {
          _hideTextNotifier.value = !isHidden;
        },
        child: Icon(
          isHidden ? Icons.visibility : Icons.visibility_off,
          color: AppColors.secondary,
        ),
      );
    }
    return null;
  }
}
