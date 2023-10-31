import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  primary: Color.fromARGB(255, 0, 0, 0), // Hour
  secondary: Color.fromARGB(255, 0, 0, 0), // Minute
  tertiary: Color.fromARGB(255, 255, 0, 0), // Second
  surface: Color.fromARGB(255, 255, 255, 255), // Dial
  outline: Color.fromARGB(255, 0, 0, 0), // Marker
  background: Color.fromARGB(255, 255, 255, 255),
  error: Color.fromARGB(255, 126, 126, 126), // Toggler
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);

const darkColorScheme = ColorScheme(
  primary: Color.fromARGB(255, 0, 255, 255), // Hour
  secondary: Color.fromARGB(255, 0, 255, 255), // Minute
  tertiary: Color.fromARGB(255, 0, 255, 255), // Second
  surface: Color.fromARGB(255, 0, 0, 0), // Dial
  outline: Color.fromARGB(255, 0, 255, 255), // Marker
  background: Color.fromARGB(255, 0, 0, 0),
  error: Color.fromARGB(255, 126, 126, 126), // Toggler
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.black,
  brightness: Brightness.dark,
);
