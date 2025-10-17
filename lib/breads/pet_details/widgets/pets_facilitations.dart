import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class PetsFacilitations extends StatelessWidget {
  final String title, facilitateValue;
  const PetsFacilitations({
    super.key,
    required this.title,
    required this.facilitateValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        spacing: 5.h,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          Text(facilitateValue,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: AppColors.grey)),
        ],
      ),
    );
  }
}
