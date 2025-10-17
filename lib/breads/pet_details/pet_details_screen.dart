import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/core/common/widgets/icons/favorite_icon.dart';
import 'package:breads/core/common/widgets/images/pet_image.dart';
import 'package:breads/core/common/widgets/texts/location_icon_with_km.dart';
import 'package:breads/core/common/widgets/texts/section_heading.dart';
import 'package:breads/core/constants/app_colors.dart';
import 'package:breads/core/constants/app_strings.dart';
import 'package:breads/core/constants/spacing.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/helper/helper_functions.dart';
import 'widgets/pets_facilitations.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetModelResponse pets;
  const PetDetailsScreen({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    final imageUrl = pets.referenceImageId.toImageUrl();
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              PetImage(
                image: imageUrl,
                width: double.infinity,
                height: AppHelperFunctions.screenHeight(context) / 2,
                padding: 14,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(
                            Iconsax.arrow_left_1_copy,
                          )),
                      FavoriteIcon(petId: pets.id),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 14, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text(pets.name,
                    style: Theme.of(context).textTheme.headlineMedium),
                LocationIconWithKM(energyLevel: pets.energyLevel),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 12.h,
                  children: [
                    PetsFacilitations(
                      title: AppStrings.intelligence,
                      facilitateValue: '${pets.intelligence}/10',
                    ),
                    PetsFacilitations(
                      title: AppStrings.lifeSpan,
                      facilitateValue: pets.ageRange,
                    ),
                    PetsFacilitations(
                      title: AppStrings.weight,
                      facilitateValue: pets.weight.weight,
                    ),
                  ],
                ),
                verticalSpace(10),
                SectionHeading(text: AppStrings.about, isActionButton: false),
                Text(
                  pets.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: AppColors.darkGrey),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
