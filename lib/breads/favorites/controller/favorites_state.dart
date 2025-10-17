import '../data/model/favorite_pet.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<String> favorites;
  final List<FavoritePet> details;

  FavoritesLoaded(this.favorites, {this.details = const []});
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}
