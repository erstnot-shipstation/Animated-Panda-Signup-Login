import 'package:flutter/material.dart';

enum TreatmentStage { oP, inProgress, done }

class GlobalConstants {
  GlobalConstants._();

  static const double neumorphicDepth = 8;
  static const double neumorphicIntensity = 1;
  static const double neumorphicSurfaceIntensity = 10;

  static const int globalAnimationDuration = 200;
  static const double neumorphicButtonHeight = 0.12;
  static const double edgeRadius = 10;
  static const double globalPadding = 20;
  static const Size productSize = Size(150, 200);
  static Color shimmerBaseColor = Colors.grey[100]!;
  static Color shimmerHighlightColor = Colors.grey[300]!;
}
