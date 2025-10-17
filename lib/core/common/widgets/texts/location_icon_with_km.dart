import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../constants/app_colors.dart';

class LocationIconWithKM extends StatelessWidget {
  const LocationIconWithKM({
    super.key,
    required this.energyLevel,
  });

  final int energyLevel;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Icon(Iconsax.location, color: AppColors.orange),
        Text('$energyLevel km away')
      ],
    );
  }
}
