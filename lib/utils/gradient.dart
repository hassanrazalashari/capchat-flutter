// gradient_helper.dart
import 'package:flutter/material.dart';

class GradientHelper {
  static LinearGradient backgroundGradient() {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black, Color.fromARGB(255, 49, 48, 48)],
    );
  }

  static LinearGradient buttonGradient() {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromARGB(255, 61, 78, 109),
        Color.fromARGB(255, 50, 50, 50)
      ], // Teal to Light Blue
    );
  }

  static LinearGradient appbarGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black, Color.fromARGB(255, 49, 48, 48)],
    );
  }

  static LinearGradient bottomnavigationbarGradient() {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black, Color.fromARGB(255, 49, 48, 48)],
    );
  }

  static LinearGradient iconGradient() {
    return LinearGradient(
      colors: [
        Color.fromARGB(255, 113, 150, 220),
        Color.fromARGB(255, 114, 98, 98)
      ], // Teal to Light Blue

      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient sentbubble() {
    return LinearGradient(
      colors: [
        // Color.fromARGB(255, 87, 61, 91),
        Color.fromARGB(255, 62, 61, 61),
        Color.fromARGB(255, 21, 74, 51)
      ], // Teal to Light Blue

      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient recievedbubble() {
    return LinearGradient(
      colors: [
        // Color.fromARGB(255, 2, 7, 63),
        Color.fromARGB(255, 2, 7, 63),
        // Color.fromARGB(255, 64, 67, 7)
        Color.fromARGB(255, 62, 61, 61)
      ], // Teal to Light Blue

      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
