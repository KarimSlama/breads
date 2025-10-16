import 'package:breads/breads/search/controller/search_bloc.dart';
import 'package:breads/core/service_locator/dependency_injections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorites/controller/favorites_cubit.dart';
import 'controller/navigation_cubit.dart';
import 'navigation_menu.dart';
import '../home/home_screen.dart';
import '../home/controller/home_cubit.dart';
import '../favorites/favorites_screen.dart';
import '../messages/messages_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationMenuLayout extends StatelessWidget {
  const MainNavigationMenuLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NavigationCubit>()),
        BlocProvider(create: (context) => getIt<FavoritesCubit>()),
      ],
      child: BlocBuilder<NavigationCubit, NavigationItem>(
        builder: (context, currentIndex) {
          return NavigationMenu(
            child: IndexedStack(
              index: currentIndex.index,
              children: [
                BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: const HomeScreen(),
                ),
                const FavoritesScreen(),
                const MessagesScreen(),
                const ProfileScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
