import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'package:serviz/utils/colors.dart';

class CustomScrollViewText extends StatelessWidget {
  const CustomScrollViewText({super.key, required this.offset});

  final double offset;

  @override
  Widget build(BuildContext context) {
    const double maxExtent = 380;
    const double minExtent = 180;

    final double shrinkOffset = offset;

    final expendPercentage =
        1.0 - min(1, shrinkOffset / (maxExtent - minExtent));

    final interpolatedBackgroundColor = Color.lerp(
      AppColors.grey_background,
      AppColors.grey_background,
      expendPercentage,
    );
    final interpolatedAlignment = Alignment.lerp(
      Alignment.bottomLeft,
      Alignment.centerRight,
      expendPercentage,
    );
    final interpolatedTextStyle = TextStyle.lerp(
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white_text,
      ),
      const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.white_text,
      ),
      expendPercentage,
    );

    return Container(
      height: minExtent + (maxExtent - minExtent) * expendPercentage,
      color: interpolatedBackgroundColor,
      alignment: interpolatedAlignment,
      child: Text(
        'Class Groups',
        style: interpolatedTextStyle,
      ),
    );
  }
}
