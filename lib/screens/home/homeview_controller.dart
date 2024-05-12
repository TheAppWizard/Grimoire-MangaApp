import 'dart:convert';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:grimoire/helpers/constants/app_constants.dart';
import 'package:grimoire/helpers/constants/app_logger.dart';
import 'package:grimoire/helpers/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';




class HomeViewController extends GetxController {

  var selectedIndex = 0.obs;
  var setTabName = 'home'.obs;
  final mangaList = [].obs;
  final mangaSavedList = [].obs;
  final chapterList = [].obs;
  final chapterFeed = [].obs;

  final savingList = [].obs;
  final retList = [].obs;
  final hashValue = ''.obs;
  var isLoading = false.obs;
  var isViewMore = false.obs;

  var showWarning = false.obs;
  var isConnected = false.obs;


  ///Temp Data
  var title = ''.obs;
  var contentRating = ''.obs;
  var imageUrl  = ''.obs;
  var description = ''.obs;
  var originalLanguage = ''.obs;
  var lastChapter = ''.obs;
  var malID = ''.obs;
  var mangaID = ''.obs;
  /// Temp Data




  AppPrinter appPrinter = AppPrinter();


  void changePage(int index) {
    selectedIndex.value = index;
  }

  void viewMore(){
    isViewMore(true);
  }

  void viewLess(){
    isViewMore(false);
  }


  void checkContentRating(){
    if(contentRating.value.toString().toLowerCase() == 'erotica' || contentRating.value.toString().toLowerCase() == 'pornographic'){
      appPrinter.printWithTag("Type", contentRating.value.toString().toLowerCase());
      showWarning(true);
    }
    else {
      showWarning(false);
    }

  }

  void selectedTab(String name){
    setTabName.value = name;
    appPrinter.printWithTag('Tab Name', '$name');
  }


  ///Same for home and Search
  Future<void> searchManga(String title) async {
    isLoading(true);
    try {
      List<Map<String, dynamic>> fetchedMangaList = await ApiService().searchManga(title);
      mangaList.value = fetchedMangaList;
      appPrinter.printWithTag('Manga in Controller',mangaList.toString());
      isLoading(false);
    } catch (e) {
      appPrinter.printWithTag('Manga in Controller',e.toString());
    }
  }

  Future<void> getChapterData() async {
    isLoading(true);
    appPrinter.printWithTag('Manga ID :: ', mangaID.value);
    try {
      List<Map<String, dynamic>> fetchedChapterList = await ApiService().fetchMangaChapters(mangaID.value);

      // Sort the fetchedChapterList by volume
      fetchedChapterList.sort((a, b) => (a['volume'] ?? "").compareTo(b['volume'] ?? ""));

      chapterList.value = fetchedChapterList;
      appPrinter.printWithTag('Chapters in Controller', chapterList.toString());
      isLoading(false);
    } catch (e) {
      appPrinter.printWithTag('Manga in Controller', e.toString());
    }
  }


  ///Recover chapter
  Future<void> recoverChapter(String chapterID) async {
    try {
      List<Map<String, dynamic>> recChapter = await ApiService().fetchChapterData(chapterID);
      mangaList.value = recChapter;

      for (var chapter in recChapter) {
        var hash = chapter['hash'];
        var data = chapter['data'];
        for (var item in data) {
          chapterFeed.add(item);
        }
        hashValue.value = hash.toString();
      }

      appPrinter.printWithTag('recovered in Controller', mangaList.toString());
      update();
    } catch (e) {
      appPrinter.printWithTag('recovered in Controller', e.toString());
    }
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
      isConnected.value = (connectivityResult.contains(ConnectivityResult.none)) ;
  }



















  ///For Detail Navigation
  void tempData(
      String titleX,
      String contentRatingX,
      String imageUrlX,
      String descriptionX,
      String originalLanguageX,
      String lastChapterX,
      String mangaIDX,
      String malIDX ) {
          title.value = titleX;
          contentRating.value = contentRatingX;
          imageUrl.value  = imageUrlX;
          description.value = descriptionX;
          originalLanguage.value = originalLanguageX;
          lastChapter.value = lastChapterX;
          malID.value = malIDX;
          mangaID.value = mangaIDX;
     }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> saveData = {
      "mangaTitle": title.value,
      "contentRating": contentRating.value,
      "coverArtId": imageUrl.value,
      "description": description.value,
      "originalLanguage": originalLanguage.value,
      "lastChapter": lastChapter.value,
      "mangaId": mangaID.value,
      "malLink": malID.value,
    };

    // Convert the Map to a JSON string
    String jsonData = json.encode(saveData);


    List<String> savingList = prefs.getStringList(AppConstants.mangaSave) ?? [];
    savingList.add(jsonData);
    await prefs.setStringList(AppConstants.mangaSave, savingList);
  }


  Future<void> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> savedDataList = prefs.getStringList(AppConstants.mangaSave) ?? [];

    List savingList = savedDataList.map((jsonData) => json.decode(jsonData)).toList();

    savingList.forEach((savedData) {
      String mangaTitle = savedData["mangaTitle"];
      String contentRating = savedData["contentRating"];
      String coverArtId = savedData["coverArtId"];
      String description = savedData["description"];
      String originalLanguage = savedData["originalLanguage"];
      String lastChapter = savedData["lastChapter"];
      String mangaId = savedData["mangaId"];
      String malLink = savedData["malLink"];

      print("Manga Title: $mangaTitle");
      print("Content Rating: $contentRating");
      print("Cover Art ID: $coverArtId");
      print("Description: $description");
      print("Original Language: $originalLanguage");
      print("Last Chapter: $lastChapter");
      print("Manga ID: $mangaId");
      print("MAL Link: $malLink");

      Map<String, dynamic> retData = {
        "mangaTitle": mangaTitle,
        "contentRating": contentRating,
        "coverArtId": coverArtId,
        "description": description,
        "originalLanguage": originalLanguage,
        "lastChapter": lastChapter,
        "mangaId": mangaId,
        "malLink": malLink,
      };

      mangaSavedList.add(retData);
    });
  }



  void clearAll () {
      hashValue.value = "";
      chapterFeed.clear();
      chapterList.clear();
      mangaSavedList.clear();
     }

}


