import 'package:flutter/material.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/helpers/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.accentColor.withOpacity(1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: AppText(
            text :text,
            fontSize: 15,
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}