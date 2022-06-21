
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {



  static final primaryLight = ThemeData(
    

    inputDecorationTheme:  InputDecorationTheme(

      // enabledBorder: OutlineInputBorder(),

    border: OutlineInputBorder(
      
      
      borderRadius: BorderRadius.circular(20)),
      
      errorStyle: TextStyle(color: Colors.grey),
      
      prefixIconColor:Colors.grey),
textTheme: GoogleFonts.openSansTextTheme(

  TextTheme(
    
    // subtitle1: TextStyle(color: Colors.black),
    // headline3: TextStyle(color: Colors.white),
    // headline4: TextStyle(color: Colors.white)
    
    )
),


  );




}
