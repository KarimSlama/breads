import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/repository/pets_repository.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PetsRepository petsRepository;
  final PagingController<int, PetModelResponse> pagingController =
      PagingController(firstPageKey: 1);

  HomeCubit(this.petsRepository) : super(InitialState()) {
    pagingController.addPageRequestListener((pageKey) {
      fetchAllPets(pageKey);
    });
  }

  static const _pageSize = 10;

  Future<void> fetchAllPets(int pageKey) async {
      final result = await petsRepository.fetchAllPets(
        limit: _pageSize,
        page: pageKey,
      );

      result.when(
        success: (pets) {
          if (pets.isEmpty && pageKey == 1) {
           
            pagingController.appendLastPage([]);
            return;
          }

          final isLastPage = pets.length < _pageSize;

          if (isLastPage) {
            pagingController.appendLastPage(pets);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(pets, nextPageKey);
          }
        },
        failure: (error) {
          pagingController.error = error;
        },
      );
  
  }

  void refresh() {
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}