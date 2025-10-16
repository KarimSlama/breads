import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onSearchChanged;
  final TextEditingController? controller;
  final bool enabled;

  const SearchBarWidget({
    super.key,
    this.onFilterTap,
    this.onSearchChanged,
    this.controller,
    this.enabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onSearchChanged,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: AppColors.grey),
        filled: true,
        fillColor: AppColors.grey.withValues(alpha: .1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
          child: Icon(
            Iconsax.search_normal_1_copy,
            color: AppColors.grey,
            size: 20.sp,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 4.w, start: 12.w),
          child: IconButton(
            onPressed: onFilterTap,
            padding: EdgeInsets.zero,
            icon: Icon(
              Iconsax.filter_copy,
              color: AppColors.grey,
              size: 24.sp,
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
