import 'dart:math';
import 'package:flutter/material.dart';

double minSizeOfScreen(context) {
  return min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
}