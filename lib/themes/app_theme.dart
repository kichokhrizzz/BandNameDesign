import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme{

  static const Color primary = Colors.white;
  static const Color secondary = Color.fromRGBO(36, 161, 146, 1);

  static final ThemeData lightTheme =  ThemeData.light().copyWith(

   //AppBar Theme
    appBarTheme: const AppBarTheme(
        color: primary,
        centerTitle: true,
        elevation: 1,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondary,
      elevation: 1,
    ),


  );

}

