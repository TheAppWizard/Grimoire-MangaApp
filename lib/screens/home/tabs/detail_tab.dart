import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/helpers/widgets/app_chapter_tile_widget.dart';
import 'package:grimoire/helpers/widgets/warning_widget.dart';
import 'package:grimoire/screens/reader/readerview.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/widgets/app_button.dart';
import '../../../helpers/widgets/app_text.dart';
import '../homeview_controller.dart';

class DetailTab extends StatefulWidget {

  DetailTab({super.key});

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  final HomeViewController homeController = Get.put(HomeViewController());
  AppPrinter appPrinter = AppPrinter();

  @override
  void initState() {
    // TODO: implement initState
    homeController.clearAll();
    homeController.getChapterData();
    homeController.checkContentRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Obx(() => AppText(
                        text: homeController.title.value,
                        color: AppColors.accentColor,
                        fontSize: 22,
                        maxLines: 3,
                      ))),
              Row(
                children: [
                  Obx(
                    () => Stack(
                      children: [
                        homeController.imageUrl.value.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Opacity(
                                  opacity: homeController.contentRating.value
                                                  .toString()
                                                  .toLowerCase() ==
                                              'erotica' ||
                                          homeController.contentRating.value
                                                  .toString()
                                                  .toLowerCase() ==
                                              'pornographic'
                                      ? 0.2
                                      : 1,
                                  child: Image.network(
                                    homeController.imageUrl.value,
                                    width: 200.0,
                                    height: 240.0,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              )
                            : const Placeholder(
                                color: Colors.grey,
                                fallbackHeight: 200.0,
                                fallbackWidth: 240.0,
                              ),
                        if (homeController.contentRating.value
                                .toString()
                                .toLowerCase() ==
                            'erotica') // Add this condition to show the badge
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.warning_amber,
                              color: AppColors
                                  .warningColor, // Customize the icon color as needed
                            ),
                          ),
                        if (homeController.contentRating.value
                                .toString()
                                .toLowerCase() ==
                            'pornographic') // Add this condition to show the badge
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.error_outline,
                              color: AppColors
                                  .errorColor, // Customize the icon color as needed
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Original Language',
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 12,
                          maxLines: 3,
                        ),
                        Obx(() => AppText(
                              text: homeController.originalLanguage.value,
                              color: AppColors.accentColor,
                              fontSize: 20,
                              maxLines: 3,
                            )),
                        AppText(
                          text: 'Content Rating',
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 12,
                          maxLines: 3,
                        ),
                        Obx(() => AppText(
                              text: homeController.contentRating.value,
                              color: AppColors.accentColor,
                              fontSize: 20,
                              maxLines: 3,
                            )),
                        AppText(
                          text: 'MAL ID',
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 12,
                          maxLines: 3,
                        ),
                        Obx(() => AppText(
                              text: homeController.malID.value.isNotEmpty
                                  ? homeController.malID.value
                                  : "N/A",
                              color: AppColors.accentColor,
                              fontSize: 20,
                              maxLines: 3,
                            )),
                        AppText(
                          text: 'Chapters',
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 12,
                          maxLines: 3,
                        ),
                        Obx(() => AppText(
                              text: homeController.lastChapter.value.isNotEmpty
                                  ? homeController.lastChapter.value
                                  : "N/A",
                              color: AppColors.accentColor,
                              fontSize: 20,
                              maxLines: 3,
                            )),


                        AppText(
                          text: 'Save Manga',
                          color: AppColors.textColor.withOpacity(0.7),
                          fontSize: 12,
                          maxLines: 3,
                        ),

                        AppButton( text: 'Save',
                          onPressed: () {
                            homeController.saveData();
                          },)
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Obx(() => Visibility(
                  visible: homeController.showWarning.value,
                  child:  const WarningWidget(),),
              ),),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: 'Description',
                  color: AppColors.textColor.withOpacity(0.5),
                  fontSize: 18,
                  maxLines: 3,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Obx(() => AppText(
                        text: homeController.description.value,
                        color: Colors.white,
                        fontSize: 14,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: 'Chapters',
                  color: AppColors.textColor.withOpacity(0.5),
                  fontSize: 18,
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 30,
              ),


              Obx(() {
                if (homeController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.accentColor,), // Show circular progress indicator
                  );
                } else if (homeController.chapterList.isEmpty) {
                  return  const Center(
                    child: AppText(text: 'Opps !.. No Chapters',color: AppColors.accentColor,)
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homeController.chapterList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> chapter = homeController.chapterList[index];

                       return
                         InkWell(
                           onTap: () {
                             appPrinter.printWithTag('Chapter Id', chapter['id'].toString() );
                             homeController.recoverChapter(chapter['id'].toString());
                             Get.to(ReaderView(chapterName: chapter['title'].toString(),));
                           },
                           child: ChapterTile(
                             volume: chapter['volume'] ?? "",
                             chapterName: chapter['title'] ?? "",
                             chapterNumber: (index+1).toString()
                         ),);
                    },
                  );
                }
              }),


            ],
          ),
        ));
  }
}
