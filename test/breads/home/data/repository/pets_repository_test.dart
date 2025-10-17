import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/network/pet_service.dart';
import 'package:breads/breads/home/data/repository/pets_repository.dart';
import 'package:breads/core/networking/api_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPetsService extends Mock implements PetService {}

void main() {
  late MockPetsService mockPetService;
  late PetsRepository petsRepository;

  setUp(() {
    mockPetService = MockPetsService();
    petsRepository = PetsRepository(mockPetService);
  });

  group(
    "Test API to Fetch All Pets",
    (() {
      final fakePets = [
        PetModelResponse(
          id: '1',
          name: 'Persian Cat',
          temperament: 'Calm, Friendly',
          origin: 'Iran',
          description: 'A beautiful long-haired cat',
          ageRange: '12 - 17',
          intelligence: 3,
          energyLevel: 1,
          healthIssues: 3,
          socialNeeds: 4,
          referenceImageId: 'abc123',
          weight: Weight('7 - 12'),
        ),
        PetModelResponse(
          id: '2',
          name: 'Siamese Cat',
          temperament: 'Active, Playful',
          origin: 'Thailand',
          description: 'An elegant cat with striking blue eyes',
          ageRange: '10 - 15',
          intelligence: 5,
          energyLevel: 5,
          healthIssues: 2,
          socialNeeds: 5,
          referenceImageId: 'xyz789',
          weight: Weight('6 - 14'),
        ),
      ];

      test("returns All Pets Success when API succeeds", (() async {
        when(() => mockPetService.fetchPets(limit: 10, page: 1))
            .thenAnswer((_) async => fakePets);

        final result = await petsRepository.fetchAllPets(limit: 10, page: 1);

        expect(result, isA<Success<List<PetModelResponse>>>());
        final success = result as Success<List<PetModelResponse>>;
        expect(success.data.length, 2);
        expect(success.data.first.name, 'Persian Cat');
        verify(() => mockPetService.fetchPets(limit: 10, page: 1)).called(1);
      }));

      test("returns Failure when API throws error", (() async {
        when(() => mockPetService.fetchPets(limit: 10, page: 1))
            .thenThrow(('Network error'));

        final result = await petsRepository.fetchAllPets(limit: 10, page: 1);

        expect(result, isA<Failure>());
        verify(() => mockPetService.fetchPets(limit: 10, page: 1)).called(1);
      }));

      test("should return Success with empty list when API returns no pets",
          (() async {
        when(() => mockPetService.fetchPets(limit: 10, page: 5))
            .thenAnswer((_) async => []);
        final result = await petsRepository.fetchAllPets(limit: 10, page: 5);

        expect(result, isA<Success<List<PetModelResponse>>>());
        final successResult = result as Success<List<PetModelResponse>>;
        expect(successResult.data, isEmpty);
        expect(successResult.data.length, 0);
        verify(() => mockPetService.fetchPets(limit: 10, page: 5)).called(1);
      }));

      test("should call API with correct parameters", (() async {
        when(() => mockPetService.fetchPets(limit: 5, page: 2))
            .thenAnswer((_) async => fakePets);

        await petsRepository.fetchAllPets(limit: 5, page: 2);
        verify(() => mockPetService.fetchPets(limit: 5, page: 2)).called(1);
        verifyNever(() => mockPetService.fetchPets(limit: 10, page: 1));
      }));
    }),
  );
}
