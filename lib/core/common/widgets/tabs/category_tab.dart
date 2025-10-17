import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../helper/helper_functions.dart';

class CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 20.w,
          vertical: 12.h,
        ),
        margin: EdgeInsetsDirectional.only(end: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppHelperFunctions.isDark(context)
                  ? AppColors.darkGrey
                  : AppColors.white,
          borderRadius: BorderRadius.circular(80.r),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: isSelected ? AppColors.white : AppColors.primary,
                ),
          ),
        ),
      ),
    );
  }
}
