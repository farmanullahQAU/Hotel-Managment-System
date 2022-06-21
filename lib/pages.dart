import 'package:baidarg/binder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'route_names.dart';
import 'views/home/home_view.dart';

List<GetPage> pages = [
  GetPage(name: RouteNames.HOME, page: () => const HomeView(), binding: Binder(),
  

  transition: Transition.fadeIn),

  
  
  


 
];
