
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_text.dart';

class ChapterTile extends StatelessWidget {
  final String chapterName ;
  final String chapterNumber;
  final String volume;
  const ChapterTile({super.key, required this.chapterName, required this.chapterNumber, required this.volume});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child:  Row(
        children: [
          AppText(
            text: '$volume/$chapterNumber',
            fontSize: 15,
            color: AppColors.textColor,
          ),
          const SizedBox(width: 10,),
          Expanded(child:  AppText(
            text: chapterName,
            fontSize: 12,
            color: AppColors.textColor,
            maxLines: 2,
          ),),
          const Icon(Icons.chevron_right,color: AppColors.accentColor,)
        ],
      ),
    );
  }
}
