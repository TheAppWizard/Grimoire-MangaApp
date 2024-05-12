import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_text.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const AppText(
        text:
        'Warning: The following content contains explicit material intended for mature audiences only. Viewer discretion is advised.',
        fontSize: 12,
        color: AppColors.textColor,
        maxLines: 3,
      ),
    );
  }
}