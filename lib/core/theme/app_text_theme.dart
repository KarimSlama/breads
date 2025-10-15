import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
    ),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.white,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
    ),
  );
}
