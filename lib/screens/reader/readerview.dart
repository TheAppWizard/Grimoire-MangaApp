import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grimoire/helpers/service/api_service.dart';

import '../../helpers/constants/app_colors.dart';
import '../../helpers/constants/app_constants.dart';
import '../../helpers/widgets/app_networkimage.dart';
import '../../helpers/widgets/app_text.dart';
import '../home/homeview_controller.dart';

class ReaderView extends StatelessWidget {
  final String chapterName;
  ReaderView({super.key, required this.chapterName});

  final HomeViewController homeController = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              homeController.clearAll();
              Get.back();
            },
            icon: const Icon(
              Icons.chevron_left,
              color: AppColors.accentColor,
              size: 20,
            )
        ),
          backgroundColor: AppColors.backgroundColor,
          title:  const AppText(
            text: "Reader Mode",
            color: AppColors.accentColor,
            fontSize: 18,
            maxLines: 2,
          ),
          actions: [
            IconButton(
                onPressed: (){

                },
                icon: const Icon(
                  Icons.grid_view,
                  color: AppColors.accentColor,
                  size: 20,
                )
            )

          ],
        ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AppText(
                text: chapterName,
                color: AppColors.accentColor,
                fontSize: 25,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20,),
              Container(height: 1,color: AppColors.accentColor.withOpacity(0.4),),
              const SizedBox(height: 20,),

              InteractiveViewer(
                child: Obx(() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: homeController.chapterFeed.length,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //     title: Text("${AppConstants.baseURLReadImage}/${homeController.hashValue.value}/"+homeController.chapterFeed[index],style: TextStyle(color: Colors.white),));


                    return NetworkImageWidget(imageUrl: "${AppConstants.baseURLReadImage}/${homeController.hashValue.value}/"+homeController.chapterFeed[index],);


                  },
                )),
              )
            ],
          ),
        ),
      ),


    );
  }
}
