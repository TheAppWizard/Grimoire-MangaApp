import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/widgets/app_text.dart';
import '../../../helpers/widgets/manga_item.dart';
import '../homeview_controller.dart';

class SaveTab extends StatefulWidget {
  const SaveTab({super.key});

  @override
  State<SaveTab> createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  final HomeViewController homeController = Get.put(HomeViewController());



  @override
  void initState() {
    // TODO: implement initState
    homeController.retrieveData();
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
        } else if (homeController.mangaSavedList.isEmpty) {
          return const Center(
            child: Text('No manga found.'),
          );
        } else {
          return ListView.builder(
            itemCount: homeController.mangaSavedList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> manga = homeController.mangaSavedList[index];

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