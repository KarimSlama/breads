import 'package:breads/breads/home/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/common/widgets/loading/pet_card_shimmer_loading.dart';
import '../controller/home_cubit.dart';
import '../data/model/pet_model_response.dart';
import 'no_pets_items_found.dart';

class PetsList extends StatelessWidget {
  const PetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => cubit.pagingController.refresh(),
      ),
      child: PagedListView<int, PetModelResponse>(
        pagingController: cubit.pagingController,
        builderDelegate: PagedChildBuilderDelegate<PetModelResponse>(
          itemBuilder: (context, pet, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: PetCard(pets: pet),
          ),

          // First page loading
          firstPageProgressIndicatorBuilder: (context) =>
              PetCardShimmerLoading(),

          // Next page loading
          newPageProgressIndicatorBuilder: (context) => Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          ),

          // First page error
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load pets',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => cubit.refresh(),
                  child: Text('Retry'),
                ),
              ],
            ),
          ),

          // Next page error
          newPageErrorIndicatorBuilder: (context) => NoPetsItemsFound(),

          // No items found
          noItemsFoundIndicatorBuilder: (context) => NoPetsItemsFound(),

          // No more items (optional)
          noMoreItemsIndicatorBuilder: (context) => Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text('No more pets to load'),
            ),
          ),
        ),
      ),
    );
  }
}

