import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import 'app_text_theme.dart';

ThemeData themeLight = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.red,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    onError: AppColors.white,
    surface: AppColors.white,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0.0,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.black,
      size: 26.sp,
    ),
    toolbarTextStyle: GoogleFonts.poppins(
      color: AppColors.black,
      fontSize: 14.sp,
    ),
    iconTheme: IconThemeData(
      color: AppColors.black,
      size: 24.sp,
    ),
  ),

  iconTheme: IconThemeData(
    color: AppColors.primary,
    size: 24.sp,
  ),
  textTheme: AppTextTheme.lightTextTheme,
  primaryColor: AppColors.primary,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      textStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      textStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Input Fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide:
          BorderSide(color: AppColors.grey.withValues(alpha: .3), width: 1.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide:
          BorderSide(color: AppColors.grey.withValues(alpha: .3), width: 1.w),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.red, width: 1.w),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.red, width: 1.5.w),
    ),
    labelStyle: GoogleFonts.poppins(
      color: AppColors.grey,
      fontSize: 14.sp,
    ),
    hintStyle: GoogleFonts.poppins(
      color: AppColors.grey,
      fontSize: 14.sp,
    ),
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: AppColors.white,
    elevation: 2,
    shadowColor: AppColors.black.withValues(alpha: .1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  ),

  // Divider
  dividerTheme: DividerThemeData(
    color: AppColors.grey.withValues(alpha: .2),
    thickness: 1.h,
  ),
);
