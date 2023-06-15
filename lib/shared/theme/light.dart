import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    dividerColor: Colors.transparent,

    iconTheme: const IconThemeData(color: black),
    scaffoldBackgroundColor: white,
    colorScheme: const ColorScheme.light(
      background: white,
      primary: primaryColor,
    ),
    appBarTheme: const AppBarTheme(color: white),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: white),
    textTheme: TextTheme(
      bodySmall: f12TextBlackRegular,
      bodyMedium: f13TextBlackRegular,
      labelMedium: f15TextBlackRegular,
      labelLarge: f15TextBlackSemibold,
      bodyLarge: f17TextBlackMedium,
      headlineLarge: f17TextBlackSemibold,
      displaySmall: f20TextBlackSemibold,
      displayMedium: f24DisplayBlackBold,
      displayLarge: f34DisplayBlackBold,
    ));
