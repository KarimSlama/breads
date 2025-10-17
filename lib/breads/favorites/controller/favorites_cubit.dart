import 'dart:convert';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/share_preference.dart';
import '../data/model/favorite_pet.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final favorites =
          await SharedPreference.getString(Constants.FAVORITES_KEY) ?? '';
      final favoriteList =
          favorites.isEmpty ? <String>[] : favorites.split(',');

      final detailsJson =
          await SharedPreference.getString(Constants.FAVORITES_DETAILS_KEY) ??
              '';
      final List<FavoritePet> details = detailsJson.isEmpty
          ? []
          : List<Map<String, dynamic>>.from(jsonDecode(detailsJson))
              .map(FavoritePet.fromMap)
              .toList();

      print('favorites are ${details.length} ids ${favoriteList}');

      emit(FavoritesLoaded(favoriteList, details: details));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String petId,
      {PetModelResponse? snapshot}) async {
    try {
      final currentState = state;
      if (currentState is FavoritesLoaded) {
        List<String> favoriteList = List.from(currentState.favorites);
        List<FavoritePet> details = List.from(currentState.details);

        if (favoriteList.contains(petId)) {
          favoriteList.remove(petId);
          details.removeWhere((e) => e.id == petId);
        } else {
          favoriteList.add(petId);
          if (snapshot != null) {
            details.removeWhere((e) => e.id == petId);
            details.add(FavoritePet(
              id: snapshot.id,
              name: snapshot.name,
              referenceImageId: snapshot.referenceImageId,
              energyLevel: snapshot.energyLevel,
            ));
          }
        }

        await SharedPreference.setData(
            Constants.FAVORITES_KEY, favoriteList.join(','));

        await SharedPreference.setData(Constants.FAVORITES_DETAILS_KEY,
            jsonEncode(details.map((e) => e.toMap()).toList()));

        emit(FavoritesLoaded(favoriteList, details: details));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String petId) {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      return currentState.favorites.contains(petId);
    }
    return false;
  }

  FavoritePet? getFavoriteDetails(String petId) {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      try {
        return currentState.details.firstWhere((e) => e.id == petId);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
