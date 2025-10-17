import 'dart:io';

import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/favorites/controller/favorites_state.dart';
import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/widgets/pet_card.dart';
import 'package:breads/core/common/widgets/icons/favorite_icon.dart';
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
  setUpAll(() {
    HttpOverrides.global = _NoNetworkHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  testWidgets("PetCard renders pet basic info text", (tester) async {
    final mockCubit = MockFavoritesCubit();

    when(() => mockCubit.state).thenReturn(FavoritesLoaded([]));
    when(() => mockCubit.isFavorite(any())).thenReturn(false);

    Widget makeTestableWidget(Widget child) {
      return wrapWithTestMaterialAppWithScreenUtil(
        BlocProvider<FavoritesCubit>.value(
          value: mockCubit,
          child: child,
        ),
      );
    }

    final pet = PetModelResponse(
      id: '1',
      name: 'Persian Cat',
      temperament: 'Calm',
      origin: 'Iran',
      description: 'Desc',
      ageRange: '12 - 17',
      intelligence: 3,
      energyLevel: 1,
      healthIssues: 2,
      socialNeeds: 3,
      referenceImageId: 'abc123',
      weight: Weight('7 - 12'),
    );

    await tester.pumpWidget(makeTestableWidget(PetCard(pets: pet)));

    await tester.pumpAndSettle();

    expect(find.text('Persian Cat'), findsOneWidget);
    expect(find.textContaining('Months old'), findsOneWidget);
    expect(find.byType(FavoriteIcon), findsOneWidget);
    expect(find.textContaining('Female'), findsOneWidget);
    expect(find.textContaining('km away'), findsOneWidget);
  });
}
