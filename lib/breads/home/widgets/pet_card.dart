import 'package:animate_do/animate_do.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/core/common/widgets/images/pet_image.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:breads/core/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/widgets/icons/favorite_icon.dart';
import '../../../core/common/widgets/texts/location_icon_with_km.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/routes.dart';

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
      onTap: () => context.pushNamed(Routes.petDetialsScreen, arguments: pets),
      child: FadeIn(
        animate: true,
        curve: Curves.bounceInOut,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppHelperFunctions.isDark(context)
                ? AppColors.black
                : AppColors.white,
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
              Hero(tag: pets.id, child: PetImage(image: imageUrl)),
              Column(
                spacing: 7.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pets.name),
                  Text('Female', style: Theme.of(context).textTheme.bodySmall),
                  Text('${pets.ageRange} Months old',
                      style: Theme.of(context).textTheme.bodySmall),
                  LocationIconWithKM(energyLevel: pets.energyLevel)
                ],
              ),
              FavoriteIcon(petId: pets.id, snapshot: pets),
            ],
          ),
        ),
      ),
    );
  }
}
