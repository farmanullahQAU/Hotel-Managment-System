import 'package:baidarg/login/login_view.dart';
import 'package:baidarg/views/home/order/order_view.dart';
import 'package:baidarg/views/stock/stock_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{



    final _currentIndex=0.obs;
  int get currentIndex=>_currentIndex.value;

  set currentIndex(int index)=>_currentIndex.value=index;


  final List<Widget> _screens=[

LoginView(),

  OrderView(),
  StockView()


  ].obs;

  List<Widget> get screens=>_screens;
}