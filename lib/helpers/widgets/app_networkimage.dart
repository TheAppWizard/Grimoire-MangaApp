import 'package:flutter/material.dart';
import 'package:grimoire/helpers/constants/app_colors.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;

  const NetworkImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double widgetHeight = screenHeight * 0.75;

    return Container(
      child: SizedBox(
        height: widgetHeight,
        child: Image.network(
          scale: 1.0,
          imageUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.accentColor,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.warning_amber,color: AppColors.warningColor,),
            );
          },
        ),
      ),
    );
  }
}