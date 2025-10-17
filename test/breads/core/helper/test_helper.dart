import 'package:bloc_test/bloc_test.dart';
import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/favorites/controller/favorites_state.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/repository/pets_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPetsRepository extends Mock implements PetsRepository {}

class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

PetModelResponse createTestPet({
  String? id,
  String? name,
  String? temperament,
  String? origin,
  String? description,
  String? ageRange,
  int? intelligence,
  int? energyLevel,
  int? healthIssues,
  int? socialNeeds,
  String? referenceImageId,
  String? weight,
}) {
  final petId = id ?? 'test_pet_1';
  return PetModelResponse(
    id: petId,
    name: name ?? 'Test Pet',
    temperament: temperament ?? 'Calm',
    origin: origin ?? 'Test Origin',
    description: description ?? 'Test description',
    ageRange: ageRange ?? '10 - 15',
    intelligence: intelligence ?? 3,
    energyLevel: energyLevel ?? 2,
    healthIssues: healthIssues ?? 1,
    socialNeeds: socialNeeds ?? 3,
    referenceImageId: referenceImageId ?? 'test_img',
    weight: Weight(weight ?? '5 - 10'),
  );
}

List<PetModelResponse> createTestPetsList({
  int count = 10,
  String prefix = 'pet',
}) {
  return List.generate(
    count,
    (i) => createTestPet(
      id: '${prefix}_$i',
      name: 'Test Pet $i',
      referenceImageId: 'img_$i',
    ),
  );
}

void setupMockFavoritesCubit(
  MockFavoritesCubit mock, {
  List<String>? initialFavorites,
  bool? isFavoriteReturn,
}) {
  when(() => mock.state).thenReturn(
    FavoritesLoaded(initialFavorites ?? []),
  );

  if (isFavoriteReturn != null) {
    when(() => mock.isFavorite(any())).thenReturn(isFavoriteReturn);
  }

  when(() => mock.toggleFavorite(any()))
      .thenAnswer((_) async => Future.value());
}
