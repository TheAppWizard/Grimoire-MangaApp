

import 'package:flutter/material.dart';
import 'package:grimoire/helpers/constants/app_colors.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/helpers/widgets/app_text.dart';


class BookItemWidget extends StatelessWidget {
  final String title;
  final String contentRating;
  final String imageUrl;
  final String description;
  final String originalLanguage;
  final String lastChapter;

  const BookItemWidget({super.key, required this.title, required this.contentRating, required this.imageUrl, required this.description, required this.originalLanguage, required this.lastChapter, });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Book cover image
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: Stack(
              children: [
                imageUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Opacity(
                    opacity: contentRating.toString().toLowerCase() == 'erotica' || contentRating.toString().toLowerCase() == 'pornographic'? 0.2 : 1,
                    child: Image.network(
                      imageUrl,
                      width: 80.0,
                      height: 120.0,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
                    : const Placeholder(
                  color: Colors.grey,
                  fallbackHeight: 120.0,
                  fallbackWidth: 80.0,
                ),
                if (contentRating.toString().toLowerCase() == 'erotica') // Add this condition to show the badge
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.warning_amber,
                      color: AppColors.warningColor, // Customize the icon color as needed
                    ),
                  ),
                if (contentRating.toString().toLowerCase() == 'pornographic') // Add this condition to show the badge
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.error_outline,
                      color: AppColors.errorColor, // Customize the icon color as needed
                    ),
                  ),
              ],
            ),
          ),

          // Book details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(text: title,fontSize: 18,color: AppColors.textColor,),
                Row(
                  children: [
                    AppText(text: contentRating,fontSize: 12,color: AppColors.textColor.withOpacity(0.3),),
                    AppText(text: ' ($originalLanguage)',fontSize: 12,color: AppColors.textColor.withOpacity(0.3)),
                    AppText(text: ' | Chapters $lastChapter',fontSize: 12,color: AppColors.textColor.withOpacity(0.3)),
                  ],
                ),
                AppText(text: description,fontSize: 12,color: AppColors.textColor.withOpacity(0.8),maxLines: 3,overflow: TextOverflow.ellipsis,),
                // Add more details if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}