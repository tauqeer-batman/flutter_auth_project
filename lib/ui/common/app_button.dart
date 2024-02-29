import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: AppColors.primary,
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 5.0,
        ),
      ),
    );
  }
}
