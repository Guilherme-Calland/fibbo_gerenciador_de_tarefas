import 'package:flutter/material.dart';

class AppDecorations{
  static final shadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2), 
      spreadRadius: 1, 
      blurRadius: 10, 
      offset: const Offset(0, 4), 
    ),
  ];

  static final borderRadius = BorderRadius.circular(20.0);
  static final borderRadiusSmall = BorderRadius.circular(10.0);
}