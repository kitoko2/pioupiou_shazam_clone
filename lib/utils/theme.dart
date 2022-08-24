import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shazam_clone/utils/colors.dart';

class ThemePerso {
  static final colorsSpecial =
      Get.isDarkMode ? Colors.black.withAlpha(55) : Colors.grey.shade200;
  static final ligthTheme = ThemeData.light().copyWith(
    // useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xfffafafa),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      onPrimary: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "poppins",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    cardTheme: const CardTheme(color: Colors.white),
    shadowColor: Colors.grey.withOpacity(0.1),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: "poppins",
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontFamily: "poppins",
        fontSize: 14.0,
        color: Colors.grey,
      ),
      headline1: TextStyle(
        fontFamily: "poppins",
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontFamily: "poppins",
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontFamily: "poppins",
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontFamily: "poppins",
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    // useMaterial3: true,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff16161e),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff16161e),
    ),
    scaffoldBackgroundColor: const Color(0xff16161e),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    dialogBackgroundColor: const Color.fromARGB(255, 36, 36, 41),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff16161e),
      elevation: 0,
    ),
    shadowColor: Colors.black.withOpacity(0.1),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "poppins",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    cardTheme: const CardTheme(color: Color.fromARGB(255, 36, 36, 41)),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryColor,
      onPrimary: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),

    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: "poppins",
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontFamily: "poppins",
        fontSize: 14.0,
        color: Colors.grey,
      ),
      headline1: TextStyle(
        fontFamily: "poppins",
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontFamily: "poppins",
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontFamily: "poppins",
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline6: TextStyle(
        fontFamily: "poppins",
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
