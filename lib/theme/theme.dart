import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFF7A9A);
const Color darkDarkGrey = Color(0xFF1C1718); // Corrected the Color value
const Color lessDarkGrey = Color(0xFF3D292E); // Corrected the Color value
const Color whiteWithRedTint = Color(0xFFF4F1F2); // Corrected the Color value

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: whiteWithRedTint,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: lessDarkGrey,
    surface: whiteWithRedTint,
    background: whiteWithRedTint,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: darkDarkGrey,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: darkDarkGrey),
    displayMedium: TextStyle(color: darkDarkGrey),
    bodyLarge: TextStyle(color: darkDarkGrey),
    bodyMedium: TextStyle(color: darkDarkGrey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.hovered)) {
          return primaryColor;
        }
        return Colors.grey[300]!;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.white;
        }
        return darkDarkGrey;
      }),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkDarkGrey,
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    secondary: lessDarkGrey,
    surface: darkDarkGrey,
    background: darkDarkGrey,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: whiteWithRedTint,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: whiteWithRedTint),
    displayMedium: TextStyle(color: whiteWithRedTint),
    bodyLarge: TextStyle(color: whiteWithRedTint),
    bodyMedium: TextStyle(color: whiteWithRedTint),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.hovered)) {
          return primaryColor;
        }
        return Colors.grey[700]!;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.white;
        }
        return whiteWithRedTint;
      }),
    ),
  ),
);
