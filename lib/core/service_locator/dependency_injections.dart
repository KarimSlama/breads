import 'package:breads/breads/favorites/controller/favorites_cubit.dart';
import 'package:breads/breads/home/controller/home_cubit.dart';
import 'package:breads/breads/search/controller/search_bloc.dart';
import 'package:breads/breads/home/data/network/pet_service.dart';
import 'package:breads/breads/home/data/repository/pets_repository.dart';
import 'package:breads/breads/search/data/network/search_service.dart';
import 'package:breads/breads/search/data/repository/search_repository.dart';
import 'package:breads/breads/navigation_menu/controller/navigation_cubit.dart';
import 'package:breads/core/networking/dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<PetService>(() => PetService(dio));
  getIt.registerLazySingleton<SearchService>(() => SearchService(dio));

  getIt.registerLazySingleton<PetsRepository>(() => PetsRepository(getIt()));

  getIt
      .registerLazySingleton<SearchRepository>(() => SearchRepository(getIt()));

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<SearchBloc>(() => SearchBloc(getIt()));
}
