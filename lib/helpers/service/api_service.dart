
import 'dart:convert';

import 'package:grimoire/helpers/constants/app_constants.dart';
import 'package:grimoire/helpers/constants/app_logger.dart';
import 'package:http/http.dart' as http;



class ApiService {
  AppPrinter appPrinter = AppPrinter();


  ///Search Manga
  Future<List<Map<String, dynamic>>> searchManga(String title) async {
    String url = '${AppConstants.baseUrl}/manga';
    if(title.isNotEmpty){
      url = '${AppConstants.baseUrl}/manga?title=$title';
    }
    else {
      url = '${AppConstants.baseUrl}/manga';
    }


    try {
      final response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"}
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> mangaList = [];
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> mangaData = responseData['data'];

        if (mangaData.isNotEmpty) {
          for (int i = 0; i < mangaData.length; i++) {
            Map<String, dynamic> manga = mangaData[i];

            Map<String, dynamic> attributes = manga['attributes'];
            Map<String, dynamic> titleMap = attributes['title'];
            String mangaTitle = titleMap['en'] ?? "";
            String mangaId = manga['id'];
            List<dynamic> altTitles = attributes['altTitles'];
            if (altTitles.isNotEmpty) {
              for (var altTitleMap in altTitles) {
                altTitleMap.forEach((key, value) {
                  // print('$key: $value');
                });
              }
            } else {}
            Map<String, dynamic> coverArt = manga['relationships']
                .firstWhere((relation) => relation['type'] == 'cover_art',
                orElse: () => null);
            String coverArtId = coverArt.isNotEmpty ? coverArt['id'] : '';
            // Map<String, dynamic> links = attributes['links']; // Extract links
            String malLink = '';
            String originalLanguage = attributes['originalLanguage'] ?? '';
            String status = attributes['status'] ?? '';
            String state = attributes['state'] ?? '';
            String contentRating = attributes['contentRating'] ?? '';
            String lastChapter = attributes['lastChapter'] ?? '';
            int year = attributes['year'] ?? 0;
            String createdAt = attributes['createdAt'] ?? '';
            String updatedAt = attributes['updatedAt'] ?? '';
            Map<String, dynamic> descriptionMap = attributes['description'];
            String description = descriptionMap['en'].toString() ?? '';



            // ///Creating Manga Covers
            // String coverArtURL = await fetchCoverUrls(mangaId,coverArtId);


            String coverFile = await fetchCover(coverArtId);

            String imageURL = get512pxThumbnailUrl(mangaId,coverFile);





            Map<String, dynamic> mangaJson = {
              "mangaTitle": mangaTitle,
              "mangaId": mangaId,
              "altTitles": altTitles,
              "coverArtId": imageURL,
              "malLink": malLink,
              "originalLanguage": originalLanguage,
              "status": status,
              "state": state,
              "contentRating": contentRating,
              "lastChapter": lastChapter,
              "year": year,
              "createdAt": createdAt,
              "updatedAt": updatedAt,
              "description": description
            };


            mangaList.add(mangaJson); // Add manga JSON object to the list


          }
          return mangaList;

        } else {
          throw Exception('No manga data found in response');
        }
      } else {
        appPrinter.printWithTag("Error", 'Failed to Search Manga');
        throw Exception('Failed to Search Manga');
      }
    }catch (e, s) {
      appPrinter.printWithTag("Error", e.toString());
      appPrinter.printWithTag("Stack", s.toString());
      throw Exception('Failed to Search Manga: $e');
    }
  }

  ///Fetch Covers
  Future<String> fetchCover(String coverId) async {
    String apiUrl = '${AppConstants.baseUrl}/cover/$coverId';
    try {
      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        // Request successful, return response body
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String filename = jsonResponse['data']['attributes']['fileName'];
        return filename;
      } else {
        appPrinter.printWithTag('Error', 'Failed To Get Cover');
        return '';
      }
    } catch (error) {
      appPrinter.printWithTag('Error', error.toString());
      return '';
    }
  }
  String get512pxThumbnailUrl(String mangaId, String coverFilename) {
    return '${AppConstants.baseURLCover}/$mangaId/$coverFilename.512.jpg';
  }


  ///Fetch Manga Chapters
  Future<List<Map<String, dynamic>>> fetchMangaChapters(String mangaId) async {
    String url = '${AppConstants.baseUrl}/manga/$mangaId/feed?translatedLanguage[]=en';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> chapters = [];
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> chapterData = responseData['data'];

        for (var chapter in chapterData) {
          Map<String, dynamic> attributes = chapter['attributes'];
          String title = attributes['title'] ?? '';
          String volume = attributes['volume'] ?? '';
          String chapterNumber = attributes['chapter'] ?? '';
          String id = chapter['id'] ?? '';
          int pages = attributes['pages'] ?? '';
          String translatedLanguage = attributes['translatedLanguage'] ?? '';



          Map<String,dynamic> chapterJson = {
              'title' : title,
              'volume': volume,
              'chapter': chapterNumber,
              'id': id,
              'pages': pages,
              'translatedLanguage': translatedLanguage,
          };



          // chapters.add({
          //   'volume': volume,
          //   'chapter': chapterNumber,
          //   'id': id,
          //   'pages': pages,
          //   'translatedLanguage': translatedLanguage,
          // });

          chapters.add(chapterJson);
        }

        return chapters;
      } else {
        throw Exception('Failed to fetch manga chapters: ${response.statusCode}');
      }
    } catch (e,s) {
      throw Exception('Failed to fetch manga chapters: $s');
    }
  }

  ///Recover Mnaga
  Future<List<Map<String, dynamic>>> fetchChapterData(String chapterID) async {
    print("Im chapter Id $chapterID");
    try {
      final response = await http.get(Uri.parse('${AppConstants.baseURLRead}/$chapterID'));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> chapterData = [];
        final responseData = json.decode(response.body);
        final hash = responseData['chapter']['hash'];
        final data = responseData['chapter']['data'];

        Map<String,dynamic> chapterSet =
        {
          'hash': hash,
          'data': data
        };

        chapterData.add(chapterSet);

        return chapterData;
      } else {
        // Handle other status codes
        return []; // Returning an empty list as a default value
      }
    } catch (e,s) {
      // Handle errors
      return []; // Returning an empty list as a default value
    }
  }















}