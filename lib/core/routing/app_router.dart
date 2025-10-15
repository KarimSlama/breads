import 'package:flutter/material.dart';

import '../../breads/navigation_menu/navigation_menu.dart';
import '../../breads/onboarding/onboarding_screen.dart';
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
          builder: (_) => NavigationMenu(),
        );

      default:
        return null;
    }
  }
}
