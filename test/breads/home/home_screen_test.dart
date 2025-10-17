import 'dart:io';

import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/home/controller/home_cubit.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/home_screen.dart';
import 'package:breads/breads/home/widgets/categories_tabs_list.dart';
import 'package:breads/breads/home/widgets/pet_card.dart';
import 'package:breads/breads/home/widgets/pets_list.dart';
import 'package:breads/breads/home/widgets/search_bar_widget.dart';
import 'package:breads/core/common/widgets/texts/section_heading.dart';
import 'package:breads/core/networking/api_result.dart';
import 'package:breads/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/helper/test_helper.dart';

class _NoNetworkHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Helper widget wrapper with ScreenUtil
Widget buildTestWidget(Widget child, {List<NavigatorObserver>? observers}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, _) => MaterialApp(
      home: child,
      navigatorObservers: observers ?? [],
      onGenerateRoute: (settings) {
        if (settings.name == Routes.searchScreen) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Search Screen')),
            ),
          );
        }
        return null;
      },
    ),
  );
}

void main() {
  late MockPetsRepository mockPetsRepository;
  late MockFavoritesCubit mockFavoritesCubit;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    HttpOverrides.global = _NoNetworkHttpOverrides();
    registerFallbackValue(
      MaterialPageRoute<dynamic>(builder: (_) => const Scaffold()),
    );
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    mockPetsRepository = MockPetsRepository();
    mockFavoritesCubit = MockFavoritesCubit();
    mockNavigatorObserver = MockNavigatorObserver();

    // Default stub
    when(() => mockPetsRepository.fetchAllPets(
            limit: any(named: 'limit'), page: any(named: 'page')))
        .thenAnswer((_) async => const Success(<PetModelResponse>[]));

    setupMockFavoritesCubit(mockFavoritesCubit,
        initialFavorites: [], isFavoriteReturn: false);
  });

  Widget wrapWithCubits(HomeCubit homeCubit, {List<NavigatorObserver>? observers}) {
    return buildTestWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>.value(value: homeCubit),
          BlocProvider<FavoritesCubit>.value(value: mockFavoritesCubit),
        ],
        child: const HomeScreen(),
      ),
      observers: observers,
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('renders all main components', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      // Check AppBar
      expect(find.text('Find Your Forever Pet'), findsOneWidget);
      expect(find.byIcon(Iconsax.notification_copy), findsOneWidget);

      // Check SearchBarWidget
      expect(find.byType(SearchBarWidget), findsOneWidget);

      // Check Categories section
      expect(find.text('Categories'), findsOneWidget);
      expect(find.byType(SectionHeading), findsOneWidget);
      expect(find.byType(CategoriesTabsList), findsOneWidget);

      // Check PetsList
      expect(find.byType(PetsList), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('notification icon button is tappable', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      final notificationButton = find.byIcon(Iconsax.notification_copy);
      expect(notificationButton, findsOneWidget);

      await tester.tap(notificationButton);
      await tester.pump();

      // Should not throw any errors
      expect(tester.takeException(), isNull);

      await homeCubit.close();
    });

    testWidgets('tapping SearchBar navigates to search screen',
        (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit, observers: [mockNavigatorObserver]));
      await tester.pump();

      final searchBar = find.byType(SearchBarWidget);
      expect(searchBar, findsOneWidget);

      await tester.tap(searchBar);
      await tester.pumpAndSettle();

      // Verify navigation occurred by checking if search screen appeared
      expect(find.text('Search Screen'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('tapping SearchBar triggers onTap callback',
        (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      final searchBar = find.byType(SearchBarWidget);
      expect(searchBar, findsOneWidget);

      // Just verify the tap doesn't throw errors
      await tester.tap(searchBar);
      await tester.pump();

      expect(tester.takeException(), isNull);

      await homeCubit.close();
    });

    testWidgets('displays pets when data is loaded', (tester) async {
      final pets = createTestPetsList(count: 3);
      when(() => mockPetsRepository.fetchAllPets(
              limit: any(named: 'limit'), page: any(named: 'page')))
          .thenAnswer((_) async => Success(pets));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(find.byType(PetCard), findsWidgets);
      expect(find.text('Test Pet 0'), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('shows no pets message when list is empty', (tester) async {
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

    testWidgets('AppBar has no back button', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.automaticallyImplyLeading, isFalse);

      await homeCubit.close();
    });

    testWidgets('layout structure is correct', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      // Check Scaffold
      expect(find.byType(Scaffold), findsOneWidget);

      // Check Column in body
      final column = find
          .descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Column),
          )
          .first;
      expect(column, findsOneWidget);

      // Check Padding widget exists
      expect(find.byType(Padding), findsWidgets);

      // Check Expanded widget for PetsList
      expect(find.byType(Expanded), findsOneWidget);

      await homeCubit.close();
    });

    testWidgets('all widgets are properly sized and visible', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      // Verify widgets are on screen
      expect(tester.getRect(find.byType(SearchBarWidget)).isEmpty, isFalse);
      expect(tester.getRect(find.byType(CategoriesTabsList)).isEmpty, isFalse);
      expect(tester.getRect(find.byType(PetsList)).isEmpty, isFalse);

      await homeCubit.close();
    });

    testWidgets('section heading is not an action button', (tester) async {
      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));
      await tester.pump();

      final sectionHeading =
          tester.widget<SectionHeading>(find.byType(SectionHeading));
      expect(sectionHeading.isActionButton, isFalse);

      await homeCubit.close();
    });

    testWidgets('handles error state gracefully', (tester) async {
      when(() => mockPetsRepository.fetchAllPets(
              limit: any(named: 'limit'), page: any(named: 'page')))
          .thenAnswer((_) async => const Failure('Network error'));

      final homeCubit = HomeCubit(mockPetsRepository);
      await tester.pumpWidget(wrapWithCubits(homeCubit));

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      // Should show error message
      expect(find.text('Failed to load pets'), findsOneWidget);

      await homeCubit.close();
    });
  });
}