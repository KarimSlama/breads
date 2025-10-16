import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationItem {
  home,
  favorites,
  messages,
  profile,
}

class NavigationCubit extends Cubit<NavigationItem> {
  NavigationCubit() : super(NavigationItem.home);

  void changeTab(NavigationItem item) {
    emit(item);
  }
}
