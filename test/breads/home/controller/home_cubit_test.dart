import 'package:breads/breads/home/controller/home_cubit.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/core/networking/api_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/helper/test_helper.dart';

void main() {
  late MockPetsRepository mockPetsRepository;
  late HomeCubit homeCubit;

  setUp(() {
    mockPetsRepository = MockPetsRepository();
    homeCubit = HomeCubit(mockPetsRepository);
  });

  final fullPagePets = createTestPetsList(count: 10, prefix: 'cat');
  final lastPagePets = createTestPetsList(count: 3, prefix: 'last');
  group('HomeCubit - Pagination Tests', () {
    test('appendPage when repository returns full page (10 items)', () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer(
              (_) async => Success<List<PetModelResponse>>(fullPagePets));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.value.itemList, isNotNull);
      expect(homeCubit.pagingController.value.itemList!.length, 10);
      expect(homeCubit.pagingController.value.nextPageKey, 2);

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .called(1);
    });

    test('appendLastPage when repository returns less than page size',
        () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 2))
          .thenAnswer(
              (_) async => Success<List<PetModelResponse>>(lastPagePets));

      await homeCubit.fetchAllPets(2);

      expect(homeCubit.pagingController.value.itemList, isNotNull);
      expect(homeCubit.pagingController.value.itemList!.length, 3);
      expect(
          homeCubit.pagingController.value.nextPageKey, isNull); // no next page

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 2))
          .called(1);
    });

    test('empty first page results in empty last page', () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer((_) async => Success<List<PetModelResponse>>([]));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.value.itemList, isEmpty);
      expect(homeCubit.pagingController.value.nextPageKey, isNull);

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .called(1);
    });

    test('failure sets pagingController.error', () async {
      const errorMessage = 'Network Error';
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer((_) async => Failure(errorMessage));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.error, isNotNull);
      expect(homeCubit.pagingController.error, errorMessage);

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .called(1);
    });

    test('refresh resets controller to first page', () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer(
              (_) async => Success<List<PetModelResponse>>(fullPagePets));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.value.itemList, isNotNull);
      expect(homeCubit.pagingController.value.itemList!.length, 10);

      homeCubit.refresh();

      expect(homeCubit.pagingController.value.itemList, isNull);
      expect(homeCubit.pagingController.value.nextPageKey, 1); // back to page 1
    });

    test('multiple pages are appended correctly', () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer(
              (_) async => Success<List<PetModelResponse>>(fullPagePets));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.value.itemList!.length, 10);
      expect(homeCubit.pagingController.value.nextPageKey, 2);

      final page2Pets = createTestPetsList(count: 10, prefix: 'cat');
      
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 2))
          .thenAnswer((_) async => Success<List<PetModelResponse>>(page2Pets));

      await homeCubit.fetchAllPets(2);

      expect(homeCubit.pagingController.value.itemList!.length, 20); // 10 + 10
      expect(homeCubit.pagingController.value.nextPageKey, 3); // page 3

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .called(1);
      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 2))
          .called(1);
    });

    test('empty page after first page marks as last page', () async {
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer(
              (_) async => Success<List<PetModelResponse>>(fullPagePets));

      await homeCubit.fetchAllPets(1);

      expect(homeCubit.pagingController.value.itemList!.length, 10);

      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 2))
          .thenAnswer((_) async => Success<List<PetModelResponse>>([]));

      await homeCubit.fetchAllPets(2);

      expect(homeCubit.pagingController.value.itemList!.length, 10); // still 10
      expect(homeCubit.pagingController.value.nextPageKey, isNull); // last page
    });
  });

  tearDown(() {
    homeCubit.close();
  });
}
