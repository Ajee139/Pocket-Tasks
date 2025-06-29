import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white54),
    titleLarge: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
  ),
);