import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grimoire/helpers/constants/app_colors.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/helpers/widgets/app_text.dart';

import '../../../helpers/widgets/manga_item.dart';
import '../homeview_controller.dart';

class HomeTab extends StatefulWidget {

   const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeViewController homeController = Get.put(HomeViewController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.clearAll();
    homeController.searchManga('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
     body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accentColor,), // Show circular progress indicator
          );
        } else if (homeController.mangaList.isEmpty) {
          return const Center(
            child: Text('No manga found.'),
          );
        } else {
          return ListView.builder(
            itemCount: homeController.mangaList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> manga = homeController.mangaList[index];

              return InkWell(
                onTap: (){
                  homeController.selectedTab('detail');
                  // homeController.getChapterData();
                  homeController.
                  tempData(
                      manga['mangaTitle'],
                      manga['contentRating'],
                      manga['coverArtId'],
                      manga['description'],
                      manga['originalLanguage'],
                      manga['lastChapter'],
                      manga['mangaId'],
                      manga['malLink'],

                  );
                },
                child: BookItemWidget(
                  title: manga['mangaTitle'],
                  imageUrl: manga['coverArtId'],
                  contentRating: manga['contentRating'],
                  description: manga['description'],
                  originalLanguage: manga['originalLanguage'],
                  lastChapter: manga['lastChapter'],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
