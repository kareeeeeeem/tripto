import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  //////////////////////////////////////// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    cardColor: const Color.fromARGB(255, 243, 241, 241),
    
    // Text
    textTheme: GoogleFonts.loraTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    
    // Icons
    iconTheme: const IconThemeData(color: Color(0xFF002E70)),
    
    // Text Selection
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.grey,
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF002E70),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF002E70),
        side: const BorderSide(color: Color(0xFF002E70), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF002E70)),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF002E70)),
      ),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF002E70),
      unselectedItemColor: Colors.grey,
    ),

    // Divider
    dividerColor: Colors.grey.shade400,

    // SnackBar
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF002E70),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );












  /////////////////////////////////////////////// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color(0xFF1E1E1E),
    
    // Text
    textTheme: GoogleFonts.loraTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    
    // Icons
    iconTheme: const IconThemeData(color: Color(0xFF002E70)),
    
    // Text Selection
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.grey,
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF002E70),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF002E70),
        side: const BorderSide(color: Color(0xFF002E70), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF002E70)),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF002E70)),
      ),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xFF002E70),
      unselectedItemColor: Colors.grey,
    ),

    // Divider
    dividerColor: Colors.grey.shade700,

    // SnackBar
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF002E70),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
