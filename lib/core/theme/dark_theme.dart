import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import 'app_text_theme.dart';

ThemeData themeDark = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.red,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.white,
    onError: AppColors.white,
    surface: AppColors.darkGrey,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.black,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0.0,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.white,
      size: 26.sp,
    ),
    toolbarTextStyle: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 14.sp,
    ),
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
  ),

  iconTheme: IconThemeData(
    color: AppColors.primary,
  ),

  textTheme: AppTextTheme.darkTextTheme,

  primaryColor: AppColors.primary,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      textStyle: GoogleFonts.poppins(
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      elevation: 1,
      padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 24.r),
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
    fillColor: Color(0xff2A2C2E),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 14.r),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.grey.withValues(alpha: .3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.grey.withValues(alpha: .3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.red),
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
    color: Color(0xff2A2C2E),
    elevation: 2.sp,
    shadowColor: Colors.black.withValues(alpha: .3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
  ),

  // Divider
  dividerTheme: DividerThemeData(
    color: AppColors.grey.withValues(alpha: .2),
    thickness: 1.w,
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.black,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.grey,
    selectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    ),
  ),
);
