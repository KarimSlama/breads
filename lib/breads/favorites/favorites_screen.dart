import 'package:animate_do/animate_do.dart';
import 'package:breads/core/common/widgets/layouts/grid_view_layout.dart';
import 'package:breads/core/common/widgets/tabs/categories_tabs_list.dart';
import 'package:breads/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_strings.dart';
import 'controller/favorites_cubit.dart';
import 'controller/favorites_state.dart';

import 'widgets/grid_card_fav_pet.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.favoritesScreen),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 14, vertical: 10),
          child: Column(
            spacing: 16.h,
            children: [
              CategoriesTabsList(),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoaded) {
                    final favorites = state.favorites;
                    if (favorites.isEmpty) {
                      return Column(
                        children: [
                          FadeIn(
                              curve: Curves.bounceInOut,
                              child: Lottie.asset(Assets.animations.emptyFile)),
                          const Center(child: Text(AppStrings.favoritesDescription)),
                        ],
                      );
                    }
                    return GridViewLayout(
                      itemCount: favorites.length,
                      itemBuilder: (_, index) => GridCardFavPet(
                        petId: favorites[index],
                      ),
                    );
                  }
                  if (state is FavoritesError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
