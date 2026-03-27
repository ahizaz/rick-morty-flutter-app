import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_mortyflutter_app/feature/screen/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'feature/services/hive_service.dart';
import 'feature/controllers/character_controller.dart';

void main()async {

  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();//initialize the hive
  await HiveService.initBoxes();

  Get.put(CharacterController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      
      designSize: const Size(360, 690),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick & Morty Explorer',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black, elevation: 0),
        ),
        home: const HomePage(),
      ),
    );
  }
}