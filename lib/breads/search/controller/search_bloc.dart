import 'dart:async';
import 'package:breads/breads/search/data/repository/search_repository.dart';
import 'package:breads/core/constants/app_strings.dart';
import 'package:breads/core/helper/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'search_event.dart';
import 'search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) =>
      events.distinct().debounceTime(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;
  
  SearchBloc(this.searchRepository) : super(SearchInitial()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    
    print('🔍 Search triggered for: $query');
    
    if (query.isEmpty || query.length < 2) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final result = await searchRepository.searchPets(query);
      
      result.when(
        success: (pets) {
          if (!emit.isDone) {
            emit(SearchLoaded(pets));
          }
        },
        failure: (error) {
          if (!emit.isDone) {
            emit(SearchError(error));
          }
        },
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(SearchError(AppStrings.unexpectedError));
      }
    }
  }
}