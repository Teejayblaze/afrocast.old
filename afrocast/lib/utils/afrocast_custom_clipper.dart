import 'package:flutter/material.dart';

class AfrocastCustomClipper extends CustomClipper<Path> {
  final Path path = new Path();

  @override
  Path getClip(Size size) {

    this.path.lineTo(0.0, size.height - 50);
    this.path.lineTo(size.width, size.height);
    this.path.lineTo(size.width, 0.0);
    this.path.close();

    return this.path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}