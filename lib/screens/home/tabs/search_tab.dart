import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/widgets/app_text.dart';
import '../../../helpers/widgets/manga_item.dart';
import '../homeview_controller.dart';

class SearchTab extends StatefulWidget {

  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final HomeViewController homeController = Get.put(HomeViewController());


  @override
  void initState() {
    // TODO: implement initState
    homeController.clearAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: AppColors.accentColor,width: 2), // Add border
              ),
              child:  TextField(
                onSubmitted: (value) {
                  homeController.searchManga(value);
                },
              style: const TextStyle(color: Colors.white,fontFamily: AppConstants.fontFamily),
              decoration: const InputDecoration(
              hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: AppColors.accentColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
              ),),
            ),
            Obx(() {
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                        title: manga['mangaTitle'] ?? "",
                        imageUrl: manga['coverArtId'] ?? "",
                        contentRating: manga['contentRating'] ?? "",
                        description: manga['description'] ?? "",
                        originalLanguage: manga['originalLanguage'] ?? "",
                        lastChapter: manga['lastChapter'] ?? "",
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}