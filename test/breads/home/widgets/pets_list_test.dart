import 'dart:io';

import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/home/controller/home_cubit.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/widgets/no_pets_items_found.dart';
import 'package:breads/breads/home/widgets/pets_list.dart';
import 'package:breads/breads/home/widgets/pet_card.dart';
import 'package:breads/core/common/widgets/loading/pet_card_shimmer_loading.dart';
import 'package:breads/core/networking/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/helper/helper.dart';
import '../../core/helper/test_helper.dart';

class _NoNetworkHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  late MockPetsRepository mockPetsRepository;
  late MockFavoritesCubit mockFavoritesCubit;

  setUpAll(() {
    HttpOverrides.global = _NoNetworkHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    mockPetsRepository = MockPetsRepository();
    mockFavoritesCubit = MockFavoritesCubit();

    when(() => mockPetsRepository.fetchAllPets(
            limit: any(named: 'limit'), page: any(named: 'page')))
        .thenAnswer((_) async => const Success(<PetModelResponse>[]));

    setupMockFavoritesCubit(mockFavoritesCubit,
        initialFavorites: [], isFavoriteReturn: false);
  });

  Widget wrapWithCubits(HomeCubit homeCubit) {
    return wrapWithTestMaterialAppWithScreenUtil(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>.value(value: homeCubit),
          BlocProvider<FavoritesCubit>.value(value: mockFavoritesCubit),
        ],
        child: const Scaffold(
          body: SizedBox(
            height: 600,
            child: PetsList(),
          ),
        ),
      ),
    );
  }

  group('PetsList Widget Tests', () {
    testWidgets('shows shimmer loading initially', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      expect(find.byType(PetCardShimmerLoading), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('shows error message when first page fails to load',
        (tester) async {
      when(() => mockPetsRepository.fetchAllPets(
              limit: any(named: 'limit'), page: any(named: 'page')))
          .thenAnswer((_) async => const Failure('Network error'));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      expect(find.text('Failed to load pets'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('tapping Retry button refreshes the list', (tester) async {
      var callCount = 0;
      when(() => mockPetsRepository.fetchAllPets(
          limit: any(named: 'limit'),
          page: any(named: 'page'))).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return const Failure('Network error');
        }
        return const Success(<PetModelResponse>[]);
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('No pets found'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('displays pet cards when data is loaded', (tester) async {
      final pets = createTestPetsList(count: 3);
      when(() => mockPetsRepository.fetchAllPets(
          limit: any(named: 'limit'),
          page: any(named: 'page'))).thenAnswer((_) async => Success(pets));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(PetCard), findsWidgets);
      expect(find.text('Test Pet 0'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('shows no pets found indicator when first page is empty',
        (tester) async {
      when(() => mockPetsRepository.fetchAllPets(
              limit: any(named: 'limit'), page: any(named: 'page')))
          .thenAnswer((_) async => const Success(<PetModelResponse>[]));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.text('No pets found'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('shows no more pets indicator at the end of list',
        (tester) async {
      final pets = createTestPetsList(count: 5);
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer((_) async => Success(pets));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable);
      expect(scrollable, findsOneWidget);

      await tester.dragUntilVisible(
        find.text('No more pets to load'),
        scrollable,
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      expect(find.text('No more pets to load'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('shows loading indicator when fetching next page',
        (tester) async {
      final firstPagePets = createTestPetsList(count: 10, prefix: 'page1');
      final secondPagePets = createTestPetsList(count: 10, prefix: 'page2');

      var pageRequested = 1;
      when(() => mockPetsRepository.fetchAllPets(
          limit: 10, page: any(named: 'page'))).thenAnswer((_) async {
        if (pageRequested == 1) {
          pageRequested++;
          return Success(firstPagePets);
        }
        await Future.delayed(const Duration(milliseconds: 500));
        return Success(secondPagePets);
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pumpAndSettle();

      await tester.fling(
        find.byType(Scrollable),
        const Offset(0, -3000),
        10000,
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsWidgets);

      await tester.pumpAndSettle();

      await homeCubit.close();
    });
    testWidgets('pull to refresh works correctly', (tester) async {
      final initialPets = createTestPetsList(count: 3, prefix: 'initial');
      final refreshedPets = createTestPetsList(count: 3, prefix: 'refreshed');

      var callCount = 0;
      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return Success(initialPets);
        }
        return Success(refreshedPets);
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.text('Test Pet 0'), findsOneWidget);

      await tester.drag(
        find.byType(Scrollable),
        const Offset(0, 300),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      verify(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .called(2);

      await homeCubit.close();
    });

    testWidgets('shows error when next page fails to load', (tester) async {
      final firstPagePets = createTestPetsList(count: 10);

      var pageRequested = 1;
      when(() => mockPetsRepository.fetchAllPets(
          limit: 10, page: any(named: 'page'))).thenAnswer((_) async {
        if (pageRequested == 1) {
          pageRequested++;
          return Success(firstPagePets);
        }
        await Future.delayed(const Duration(milliseconds: 100));
        return const Failure('Failed to load more');
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pumpAndSettle();

      expect(find.byType(PetCard), findsWidgets);

      final listView = find.byType(Scrollable);

      for (int i = 0; i < 3; i++) {
        await tester.drag(listView, const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.byType(NoPetsItemsFound), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('pet card displays correct information', (tester) async {
      final pet = createTestPet(
        id: 'test_1',
        name: 'Fluffy Cat',
        origin: 'Egypt',
        temperament: 'Friendly, Playful',
      );

      when(() => mockPetsRepository.fetchAllPets(limit: 10, page: 1))
          .thenAnswer((_) async => Success([pet]));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.text('Fluffy Cat'), findsOneWidget);
      expect(find.byType(PetCard), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('list scrolls correctly with multiple items', (tester) async {
      final pets = createTestPetsList(count: 20);

      when(() => mockPetsRepository.fetchAllPets(
          limit: 10, page: any(named: 'page'))).thenAnswer((invocation) async {
        final page = invocation.namedArguments[#page] as int;
        if (page == 1) {
          return Success(pets.sublist(0, 10));
        } else {
          return Success(pets.sublist(10, 20));
        }
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.text('Test Pet 0'), findsOneWidget);

      final scrollable = find.byType(Scrollable);
      await tester.drag(scrollable, const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('Test Pet 10'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('handles rapid scrolling correctly', (tester) async {
      final pets = createTestPetsList(count: 30);

      when(() => mockPetsRepository.fetchAllPets(
          limit: 10, page: any(named: 'page'))).thenAnswer((invocation) async {
        final page = invocation.namedArguments[#page] as int;
        final start = (page - 1) * 10;
        final end = start + 10;
        if (end <= pets.length) {
          return Success(pets.sublist(start, end));
        }
        return Success(pets.sublist(start));
      });

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      final scrollable = find.byType(Scrollable);
      expect(scrollable, findsOneWidget);

      for (var i = 0; i < 3; i++) {
        await tester.drag(scrollable, const Offset(0, -300));
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();

      // Should handle without errors
      expect(find.byType(PetCard), findsWidgets);

      await homeCubit.close();
    });

    testWidgets('verifies RefreshIndicator exists', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      expect(find.byType(RefreshIndicator), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('empty list shows correct message', (tester) async {
      when(() => mockPetsRepository.fetchAllPets(
              limit: any(named: 'limit'), page: any(named: 'page')))
          .thenAnswer((_) async => const Success(<PetModelResponse>[]));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.text('No pets found'), findsOneWidget);
      expect(find.byType(PetCard), findsNothing);

      await homeCubit.close();
    });

    testWidgets('verifies PetsList widget is present', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      expect(find.byType(PetsList), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets(
      'handles scrolling to specific pet card',
      (tester) async {
        final pets = createTestPetsList(count: 15);
        when(() => mockPetsRepository.fetchAllPets(
            limit: 10,
            page: any(named: 'page'))).thenAnswer((invocation) async {
          final page = invocation.namedArguments[#page] as int;
          if (page == 1) {
            return Success(pets.sublist(0, 10));
          } else {
            return Success(pets.sublist(10, 15));
          }
        });

        final homeCubit = HomeCubit(mockPetsRepository);
        await tester.pumpWidget(wrapWithCubits(homeCubit));

        await tester.pumpAndSettle();

        expect(find.text('Test Pet 0'), findsOneWidget);

        final scrollable = find.byType(Scrollable);

        try {
          await tester.dragUntilVisible(
            find.text('Test Pet 8'),
            scrollable,
            const Offset(0, -100),
            maxIteration: 50,
          );

          expect(find.text('Test Pet 8'), findsOneWidget);

          await tester.pumpAndSettle(const Duration(seconds: 5));
        } finally {
          await homeCubit.close();
        }
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
