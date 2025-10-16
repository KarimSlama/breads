import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class NoPetsItemsFound extends StatelessWidget {
  const NoPetsItemsFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 64.sp, color: AppColors.primary),
          Text('No pets found', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}