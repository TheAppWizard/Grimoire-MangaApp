import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grimoire/helpers/constants/app_colors.dart';
import 'package:grimoire/helpers/constants/app_constants.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/helpers/service/api_service.dart';
import 'package:grimoire/helpers/widgets/app_text.dart';
import 'package:grimoire/screens/home/homeview_controller.dart';
import 'package:grimoire/screens/home/tabs/detail_tab.dart';
import 'package:grimoire/screens/home/tabs/home_tab.dart';
import 'package:grimoire/screens/home/tabs/save_tab.dart';
import 'package:grimoire/screens/home/tabs/search_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../helpers/service/data_handler.dart';



class HomeView extends StatefulWidget {

  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController homeController = Get.put(HomeViewController());

  @override
  void initState() {
    // TODO: implement initState
    DataHandler.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title:  Row(
          children: [
            const AppText(
              text: AppConstants.appName,
              color: AppColors.accentColor,
              fontSize: 25,
            ),
            const SizedBox(width: 5,),
            Obx(() {
              // if(!homeController.isConnected.value){
              //
              // }



              return Column(
                 children: [
                   const SizedBox(height: 12,),
                   AppText(
                     text: homeController.setTabName.value,
                     color: AppColors.textColor.withOpacity(0.2),
                   )
                 ],
               );
            }
            )
          ],
        ),
        actions: [
          Obx(() => homeController.setTabName.value == "saved"?   IconButton(
              onPressed: (){
                homeController.clearAll();
                DataHandler.remove(AppConstants.mangaSave);
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: AppColors.accentColor,
                size: 20,
              )
          ):Container()),



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
      body: Center(
        child:  Obx(() {
          switch (homeController.setTabName.value) {
            case 'home':
              return  const HomeTab();
            case 'search':
              return const SearchTab();
            case 'saved':
              return const SaveTab();
            case 'detail':
              return  DetailTab();
            default:
              return  const HomeTab();
          }
        }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          homeController.selectedTab('search');
        },
        shape: const CircleBorder(),
        child:  Obx(() => Container(child:
        homeController.setTabName.value == "detail"?
        const Icon(Icons.chevron_left,size: 25,) :
        const Icon(Icons.search,size: 25,)))
      ),
      bottomNavigationBar:
      BottomAppBar(
        height: 60,
        color: AppColors.backgroundColorSecondary,
        notchMargin: 20,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                homeController.selectedTab('home');
              },
              icon:  const Icon(Icons.home_outlined,color: AppColors.accentColor,),
            ),

            Container(width: 100,),


            IconButton(
              onPressed: () {
                homeController.selectedTab('saved');
              },
              icon: const Icon(Icons.bookmark_border,color: AppColors.accentColor,),
            ),

          ],
        ),
      ),
    ));
  }
}
