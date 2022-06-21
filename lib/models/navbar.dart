import 'package:flutter/material.dart';

class NavBar {
  Widget? widget;
  String routeName;
  int? index;

  VoidCallback? onTap;
  NavBar({this.widget, this.index, required this.routeName, this.onTap});
}