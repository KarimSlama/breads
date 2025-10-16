import 'package:breads/breads/search/controller/search_state.dart';
import 'package:breads/breads/home/widgets/search_bar_widget.dart';
import 'package:breads/core/common/widgets/layouts/custom_pets_list_of_cards.dart';
import 'package:breads/core/constants/app_colors.dart';
import 'package:breads/core/constants/app_strings.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'controller/search_bloc.dart';
import 'controller/search_event.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Iconsax.arrow_left_2_copy),
        ),
        title: Text(AppStrings.searchPets),
      ),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          spacing: 16.h,
          children: [
            SearchBarWidget(
              enabled: true,
              onSearchChanged: (value) =>
                  searchBloc.add(SearchQueryChanged(value)),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchInitial():
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.search_normal_1_copy,
                            size: 64.sp,
                            color: AppColors.grey,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.startTypingToSearch,
                            style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  case SearchLoading():
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.searching,
                            style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  case SearchLoaded():
                    if (state.pets.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.search_normal_1_copy,
                              size: 64.sp,
                              color: AppColors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              AppStrings.noPetsFound,
                              style: Theme.of(context).textTheme.bodyLarge?.apply(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return CustomPetsListOfCards(pets: state.pets);
                  case SearchError():
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.warning_2,
                            size: 64.sp,
                            color: AppColors.orange,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.searchError,
                            style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyMedium?.apply(
                              color: AppColors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () => searchBloc.add(SearchQueryChanged('')),
                            child: Text(AppStrings.retry),
                          ),
                        ],
                      ),
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
