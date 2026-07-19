import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  Orientation get orientation => MediaQuery.of(this).orientation;

  double scaleWidth(double val) => (screenWidth / 375.0) * val;
  double scaleHeight(double val) => (screenHeight / 864.0) * val;

  // Percentage sizing helpers
  double pctWidth(double pct) => screenWidth * pct;
  double pctHeight(double pct) => screenHeight * pct;

  // Predefined responsive paddings
  double get padLow => scaleWidth(8);
  double get padMedium => scaleWidth(16);
  double get padHigh => scaleWidth(24);
}
