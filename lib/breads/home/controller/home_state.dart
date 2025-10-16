import '../data/model/pet_model_response.dart';

sealed class HomeState {}

class InitialState extends HomeState {
  InitialState();
}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<PetModelResponse> pets;

  Loaded(this.pets);
}

class Error extends HomeState {
  final String error;
  Error(this.error);
}
