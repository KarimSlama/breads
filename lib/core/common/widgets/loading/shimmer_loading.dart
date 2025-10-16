import 'package:breads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helper/helper_functions.dart';

class AppShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;
  const AppShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDark(context);

    return Shimmer.fromColors(
      baseColor: dark ? AppColors.darkGrey : Colors.grey[300]!,
      highlightColor:
          dark ? AppColors.darkGrey.withValues(alpha: .6) : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? AppColors.darkGrey : AppColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
