import 'package:animate_do/animate_do.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/common/widgets/icons/favorite_icon.dart';
import '../../../core/constants/app_colors.dart';

class PetCard extends StatelessWidget {
  final PetModelResponse pets;
  const PetCard({
    super.key,
    required this.pets,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = pets.referenceImageId.toImageUrl();
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {},
      child: FadeIn(
        animate: true,
        curve: Curves.bounceInOut,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 10,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 7,
                offset: const Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 115.w,
                height: 115.h,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(8.r)),
                child: FadeIn(
                  child: Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
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
              ),
              Column(
                spacing: 7.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pets.name),
                  Text('Female', style: Theme.of(context).textTheme.bodySmall),
                  Text('${pets.ageRange} Months old',
                      style: Theme.of(context).textTheme.bodySmall),
                  Row(
                    spacing: 5.w,
                    children: [
                      Icon(Iconsax.location, color: AppColors.orange),
                      Text('${pets.energyLevel} km away')
                    ],
                  )
                ],
              ),
              FavoriteIcon(petId: pets.id),
            ],
          ),
        ),
      ),
    );
  }
}
