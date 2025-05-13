import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle headlineTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle normalTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      // color: Colors.black,
    );
  }

  static TextStyle boldTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      // color: Colors.black,
    );
  }

  static TextStyle whiteTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle greenTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );
  }

  static TextStyle greyTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    );
  }
}
