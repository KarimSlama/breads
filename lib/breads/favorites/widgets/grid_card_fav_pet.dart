import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common/widgets/icons/favorite_icon.dart';
import '../../../core/common/widgets/images/pet_image.dart';
import '../../../core/common/widgets/texts/location_icon_with_km.dart';

class GridCardFavPet extends StatelessWidget {
  final String petId;
  const GridCardFavPet({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final favCubit = context.read<FavoritesCubit>();
    final details = favCubit.getFavoriteDetails(petId);
    final imageUrl =
        details?.referenceImageId?.toImageUrl() ?? "j6oFGLpRG".toImageUrl();

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = constraints.maxWidth;
        final imageHeight = tileWidth * 1.25;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PetImage(
              height: imageHeight,
              width: tileWidth,
              image: imageUrl,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.w,
                    children: [
                      Text(
                        details?.name ?? petId,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      LocationIconWithKM(
                          energyLevel: details?.energyLevel ?? 1),
                    ],
                  ),
                ),
                FavoriteIcon(petId: petId),
              ],
            ),
          ],
        );
      },
    );
  }
}
