
import 'package:baidarg/app_theme.dart';
import 'package:baidarg/binder.dart';
import 'package:baidarg/firebase_options.dart';
import 'package:baidarg/menue_controller.dart';
import 'package:baidarg/pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'localization/locale_strings.dart';
import 'route_names.dart';
// Import the generated file


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
     Get.put(MenuController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final getStorage=GetStorage();
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
   // locale: const Locale('ur', 'PK'),
      // fallbackLocale: const Locale('ur', 'PK'),
   themeMode: ThemeMode.system,

    //  darkTheme: ThemeData.dark(),
//we need some custom changes in default dark theme so we use AppTheme.darkTheme
    darkTheme: ThemeData.dark(),
        title:"Baidar G",
        initialBinding: Binder(),


        getPages: pages,
        initialRoute: 
      // Get.find<MenuController>().currentRoute??RouteNames.HOME
      RouteNames.HOME
        
        
        
        
        );
  }
}
