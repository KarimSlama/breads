import '../../home/data/model/pet_model_response.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {
  SearchInitial();
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<PetModelResponse> pets;
  SearchLoaded(this.pets);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}
