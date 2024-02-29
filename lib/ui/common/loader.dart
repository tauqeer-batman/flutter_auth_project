import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation(
        AppColors.secondary,
      ),
    );
  }
}
