import 'package:bloc_test/bloc_test.dart';
import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/favorites/controller/favorites_state.dart';
import 'package:breads/core/common/widgets/icons/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/helper.dart';
import '../../../helper/test_helper.dart';


void main() {
  late MockFavoritesCubit mockFavoritesCubit;
  setUp(() {
    mockFavoritesCubit = MockFavoritesCubit();
  });

  Widget makeTestableWidget(Widget child) {
    return wrapWithTestMaterialAppWithScreenUtil(
      BlocProvider<FavoritesCubit>.value(
        value: mockFavoritesCubit,
        child: child,
      ),
    );
  }

  testWidgets('shows empty heart when pet is not favorite',
      (WidgetTester tester) async {
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesLoaded([]));

    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(
      FavoriteIcon(petId: '1'),
    ));

    expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);
    expect(find.byIcon(Iconsax.heart), findsNothing);
  });

  testWidgets('shows filled heart when pet is favorite', (tester) async {
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesLoaded(['1']));
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(true);

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '1')));

    expect(find.byIcon(Iconsax.heart), findsOneWidget);
    expect(find.byIcon(Iconsax.heart_copy), findsNothing);
  });

  testWidgets('calls toggleFavorite when icon is tapped', (tester) async {
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesLoaded([]));
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(false);
    when(() => mockFavoritesCubit.toggleFavorite(any()))
        .thenAnswer((_) async => Future.value());

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '123')));
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    verify(() => mockFavoritesCubit.toggleFavorite('123')).called(1);
  });

  testWidgets('icon updates when favorite state changes', (tester) async {
    whenListen(
      mockFavoritesCubit,
      Stream.fromIterable([
        FavoritesLoaded([]),
        FavoritesLoaded(['1'])
      ]),
      initialState: FavoritesLoaded([]),
    );

    // First one check that it's not fav.
    when(() => mockFavoritesCubit.isFavorite('1')).thenReturn(false);

    await tester.pumpWidget(
      makeTestableWidget(
        FavoriteIcon(petId: '1'),
      ),
    );
    expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);

    // Update the state to be Fav with fav icon
    when(() => mockFavoritesCubit.isFavorite('1')).thenReturn(true);
    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '1')));
    expect(find.byIcon(Iconsax.heart), findsOneWidget);
  });

  testWidgets('handles multiple pets correctly', (tester) async {
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesLoaded(['1']));
    when(() => mockFavoritesCubit.isFavorite('1')).thenReturn(true);
    when(() => mockFavoritesCubit.isFavorite('2')).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '1')));
    expect(find.byIcon(Iconsax.heart), findsOneWidget);

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '2')));
    expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);
  });

  testWidgets('widget renders with correct structure', (tester) async {
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesLoaded([]));
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '1')));

    expect(find.byType(BlocBuilder<FavoritesCubit, FavoritesState>),
        findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('handles error state gracefully', (tester) async {
    when(() => mockFavoritesCubit.state)
        .thenReturn(FavoritesError('Something went wrong'));
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(FavoriteIcon(petId: '1')));

    expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);
  });
}
