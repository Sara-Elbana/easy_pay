import 'package:flutter/material.dart';

class CustomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.15);

    path.quadraticBezierTo(
      size.width * 0.50,
      size.height * 0.75,
      size.width,
      size.height * 0.15,
    );

    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
