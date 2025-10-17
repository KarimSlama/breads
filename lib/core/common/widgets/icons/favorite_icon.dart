import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../breads/favorites/controller/favorites_cubit.dart';
import '../../../../breads/home/data/model/pet_model_response.dart';
import '../../../../breads/favorites/controller/favorites_state.dart';

class FavoriteIcon extends StatelessWidget {
  final String petId;
  final PetModelResponse? snapshot;

  const FavoriteIcon({
    super.key,
    required this.petId,
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final fav = context.read<FavoritesCubit>();

        return IconButton(
          onPressed: () => fav.toggleFavorite(petId, snapshot: snapshot),
          icon: Icon(
            fav.isFavorite(petId) ? Iconsax.heart : Iconsax.heart_copy,
            size: 24.sp,
          ),
        );
      },
    );
  }
}
