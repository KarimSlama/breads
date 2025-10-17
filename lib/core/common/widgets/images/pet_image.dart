import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../constants/app_colors.dart';

class PetImage extends StatelessWidget {
  final String image;
  final double width, height, padding;
  const PetImage(
      {super.key,
      required this.image,
      this.width = 115,
      this.height = 115,
      this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: AppColors.secondary, borderRadius: BorderRadius.circular(8.r)),
      child: FadeIn(
        child: Image.network(
          image,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Iconsax.pet,
              size: 50.sp,
              color: AppColors.primary,
            );
          },
        ),
      ),
    );
  }
}
