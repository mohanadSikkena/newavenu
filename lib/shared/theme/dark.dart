import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    dividerColor: Colors.transparent,
    appBarTheme: const AppBarTheme(color: black),
    scaffoldBackgroundColor: black,
    colorScheme: const ColorScheme.dark(background: black,primary: primaryColor),
    iconTheme: const IconThemeData(color: white),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: black),
    textTheme: TextTheme(
      bodySmall:f12TextWhiteRegular ,
      bodyMedium: f13TextWhiteRegular,


      bodyLarge: f17TextWhiteMedium,

      labelMedium: f15TextWhiteRegular,
      labelLarge: f15TextWhiteSemibold,
      headlineLarge: f17TextWhiteSemibold,
      displaySmall: f20TextWhiteSemibold,
      displayMedium: f24DisplayWhiteBold,
      displayLarge: f34DisplayWhiteBold,
    ));
