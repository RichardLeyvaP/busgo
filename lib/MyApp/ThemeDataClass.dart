  // Configuración del tema
  import 'package:BusGo/util/utils_class_style.dart';
import 'package:flutter/material.dart';

ThemeData themeDataInitial() {
    return ThemeData(
      fontFamily: StyleGlobalApk.globalTextStyle.fontFamily,
      primaryColor: const Color.fromARGB(255, 67, 162, 240),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: StyleGlobalApk.colorPrimary,
        secondary: Colors.orange,
        surface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
       // toolbarHeight: 120,
        backgroundColor: StyleGlobalApk.colorPrimary,
        titleTextStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        titleLarge: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 46.0,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleMedium: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleSmall: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        displayMedium: StyleGlobalApk.getStyleTitleApk().copyWith(
          color: StyleGlobalApk.getColorIndicador(),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(StyleGlobalApk.colorPrimary),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          textStyle: WidgetStateProperty.all<TextStyle>(
            StyleGlobalApk.globalTextStyle.copyWith(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: StyleGlobalApk.globalTextStyle.copyWith(
          fontSize: 12.0,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: StyleGlobalApk.colorPrimary,
          ),
        ),
      ),
    );
  }
