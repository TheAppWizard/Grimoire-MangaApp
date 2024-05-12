import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grimoire/helpers/constants/constants.dart';
import 'package:grimoire/screens/home/homeview.dart';

import 'helpers/constants/app_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Root(navigationName: '',),
    );
  }
}

class Root extends StatefulWidget {
  final String navigationName;
  const Root({super.key, required this.navigationName});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Get.offAll(HomeView(),transition: Transition.topLevel,duration: const Duration(seconds: 3));
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFoldingCube(color: AppColors.accentColor,size: 100,),
          ],
        ),
      ),
    );
  }
}