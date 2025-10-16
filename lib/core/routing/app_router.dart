import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/search/controller/search_bloc.dart';
import 'package:breads/core/service_locator/dependency_injections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../breads/navigation_menu/main_navigation_menu_layout.dart';
import '../../breads/onboarding/onboarding_screen.dart';
import '../../breads/search/search_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );

      case Routes.navigationMenu:
        return MaterialPageRoute(
          builder: (_) => MainNavigationMenuLayout(),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SearchBloc>(),
              ),
              BlocProvider.value(
                value: getIt<FavoritesCubit>(),
              ),
            ],
            child: SearchScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
