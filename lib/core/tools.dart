import 'dart:math';
import 'package:flutter/material.dart';

class Tools{
  static MaterialColor randomMaterialColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

}