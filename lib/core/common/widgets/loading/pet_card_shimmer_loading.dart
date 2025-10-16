import 'package:breads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'shimmer_loading.dart';

class PetCardShimmerLoading extends StatelessWidget {
  const PetCardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmerEffect(
                width: 115.w,
                height: 115.h,
                radius: 8,
                color: AppColors.secondary.withValues(alpha: .3),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    AppShimmerEffect(width: 120.w, height: 20.h),
                    AppShimmerEffect(width: 60.w, height: 14.h),
                    AppShimmerEffect(width: 80.w, height: 14.h),
                    AppShimmerEffect(width: 100.w, height: 14.h),
                  ],
                ),
              ),
              AppShimmerEffect(width: 24.w, height: 24.h, radius: 8),
            ],
          ),
        ),
      ),
    );
  }
}
