import 'package:flutter/material.dart';

class AdaptiveFontSize {
  static double getFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double baseScreenWidth = 375.0; // Standard screen width
    double scaleFactor = screenWidth / baseScreenWidth;
    return baseFontSize * scaleFactor;
  }
}
