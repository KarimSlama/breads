# Breads

A modern, production-ready Flutter application for exploring and learning about animals. Built with clean architecture principles and comprehensive testing coverage.

## About The App

Breads App is a responsive mobile application that provides users with detailed information about various animals. The app demonstrates best practices in Flutter development, including Clean Architecture, SOLID principles, and comprehensive testing strategies.

## Features

### **Clean Architecture**

- Clear separation of concerns across Presentation, Domain, and Data layers
- Independent, testable, and maintainable codebase
- Framework-agnostic business logic

### **API Integration**

- RESTful API integration using Dio and Retrofit
- Efficient network layer with proper error handling
- Automatic JSON serialization/deserialization

### **SOLID Principles**

- Separation of business logic from UI components
- Repository pattern for data abstraction
- Use cases for single-responsibility business operations
- Dependency injection for loose coupling
- Interface-based programming for testability

### **Responsive Design**

- Adaptive layouts for all screen sizes
- Seamless experience across phones and tablets
- Optimized UI components for different orientations

### **Comprehensive Testing**

- Unit tests for repositories, use cases, and business logic
- Widget tests for individual UI components and screens
- Integration tests for complete user journeys
- Mock data sources for isolated testing
- Automated test coverage reporting

### **Modern UI/UX**

- Pixel-perfect implementation of Figma designs
- Smooth animations and transitions
- Intuitive navigation and user interactions
- Consistent design system throughout the app

### **Core Functionality**

- Splash Screen: Animated app introduction with branding
- Onboarding: Interactive tutorial for first-time users
- Home Screen: Browse pets by categories (Catgories, Cat, Dog, Other, Husky)
- Pet Details: Comprehensive information including gender, age, weight, and location
- Favorites: Save and manage your favorite pets
- Search & Filter: Find pets by category and preferences
- Adoption Flow: Streamlined pet adoption process

## Tech Stack

- **Framework**: Flutter/Dart
- **Architecture**: Clean Architecture
- **State Management**: BLoC
- **Networking**: Dio + Retrofit
- **Dependency Injection**: getIt
- **Testing**: Flutter Test, Mocktail, bloc_test
- **Code Generation**: Build Runner, Json Serializable, Injectable

## Project Structure

```

breads
├─ assets
│  ├─ icons
   ├─ animations
      └─ empty-file.json
│  └─ images
│     └─ logo.png
├─ flutter_native_splash.yaml
├─ lib
│  ├─ breads
│  │  ├─ favorites
│  │  │  ├─ controller
│  │  │  │  ├─ favorites_cubit.dart
│  │  │  │  └─ favorites_state.dart
│  │  │  ├─ data
│  │  │  │  └─ model
│  │  │  │     └─ favorite_pet.dart
│  │  │  ├─ favorites_screen.dart
│  │  │  └─ widgets
│  │  │     └─ grid_card_fav_pet.dart
│  │  ├─ home
│  │  │  ├─ controller
│  │  │  │  ├─ home_cubit.dart
│  │  │  │  └─ home_state.dart
│  │  │  ├─ data
│  │  │  │  ├─ model
│  │  │  │  │  ├─ pet_model_response.dart
│  │  │  │  │  └─ pet_model_response.g.dart
│  │  │  │  ├─ network
│  │  │  │  │  ├─ pet_constants.dart
│  │  │  │  │  ├─ pet_service.dart
│  │  │  │  │  └─ pet_service.g.dart
│  │  │  │  └─ repository
│  │  │  │     └─ pets_repository.dart
│  │  │  ├─ home_screen.dart
│  │  │  └─ widgets
│  │  │     ├─ no_pets_items_found.dart
│  │  │     ├─ pets_list.dart
│  │  │     ├─ pet_card.dart
│  │  │     └─ search_bar_widget.dart
│  │  ├─ messages
│  │  │  └─ messages_screen.dart
│  │  ├─ navigation_menu
│  │  │  ├─ controller
│  │  │  │  └─ navigation_cubit.dart
│  │  │  ├─ main_navigation_menu_layout.dart
│  │  │  └─ navigation_menu.dart
│  │  ├─ onboarding
│  │  │  └─ onboarding_screen.dart
│  │  ├─ pet_details
│  │  │  ├─ pet_details_screen.dart
│  │  │  └─ widgets
│  │  │     └─ pets_facilitations.dart
│  │  ├─ profile
│  │  │  └─ profile_screen.dart
│  │  └─ search
│  │     ├─ controller
│  │     │  ├─ search_bloc.dart
│  │     │  ├─ search_event.dart
│  │     │  └─ search_state.dart
│  │     ├─ data
│  │     │  ├─ network
│  │     │  │  ├─ search_service.dart
│  │     │  │  └─ search_service.g.dart
│  │     │  └─ repository
│  │     │     └─ search_repository.dart
│  │     └─ search_screen.dart
│  ├─ breads_app.dart
│  ├─ core
│  │  ├─ common
│  │  │  ├─ local
│  │  │  └─ widgets
│  │  │     ├─ icons
│  │  │     │  └─ favorite_icon.dart
│  │  │     ├─ images
│  │  │     │  └─ pet_image.dart
│  │  │     ├─ layouts
│  │  │     │  ├─ custom_pets_list_of_cards.dart
│  │  │     │  └─ grid_view_layout.dart
│  │  │     ├─ loading
│  │  │     │  ├─ pet_card_shimmer_loading.dart
│  │  │     │  └─ shimmer_loading.dart
│  │  │     ├─ tabs
│  │  │     │  ├─ categories_tabs_list.dart
│  │  │     │  └─ category_tab.dart
│  │  │     └─ texts
│  │  │        ├─ location_icon_with_km.dart
│  │  │        └─ section_heading.dart
│  │  ├─ constants
│  │  │  ├─ app_colors.dart
│  │  │  ├─ app_strings.dart
│  │  │  ├─ constants.dart
│  │  │  ├─ spacing.dart
│  │  │  └─ validator.dart
│  │  ├─ helper
│  │  │  ├─ app_pricing_calculate.dart
│  │  │  ├─ extensions.dart
│  │  │  ├─ helper_functions.dart
│  │  │  └─ share_preference.dart
│  │  ├─ networking
│  │  │  ├─ api_constants.dart
│  │  │  ├─ api_error_handler.dart
│  │  │  ├─ api_error_model.dart
│  │  │  ├─ api_error_model.g.dart
│  │  │  ├─ api_result.dart
│  │  │  └─ dio_factory.dart
│  │  ├─ routing
│  │  │  ├─ app_router.dart
│  │  │  └─ routes.dart
│  │  ├─ service_locator
│  │  │  └─ dependency_injections.dart
│  │  └─ theme
│  │     ├─ app_text_theme.dart
│  │     ├─ dark_theme.dart
│  │     └─ light_theme.dart
│  ├─ gen
│  │  └─ assets.gen.dart
│  └─ main.dart
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
├─ test
│  ├─ breads
│  │  ├─ breads
│  │  ├─ core
│  │  │  ├─ common
│  │  │  │  └─ widgets
│  │  │  │     ├─ icons
│  │  │  │     │  └─ favorite_icon_test.dart
│  │  │  │     ├─ tabs
│  │  │  │     │  ├─ categories_tabs_list_test.dart
│  │  │  │     │  └─ category_tab_test.dart
│  │  │  │     └─ texts
│  │  │  │        └─ section_heading_test.dart
│  │  │  └─ helper
│  │  │     ├─ helper.dart
│  │  │     └─ test_helper.dart
│  │  └─ home
│  │     ├─ controller
│  │     │  └─ home_cubit_test.dart
│  │     ├─ data
│  │     │  └─ repository
│  │     │     └─ pets_repository_test.dart
│  │     ├─ home_screen_test.dart
│  │     └─ widgets
│  │        ├─ no_pets_and_shimmer_smoke_test.dart
│  │        ├─ no_pets_items_found_test.dart
│  │        ├─ pets_list_test.dart
│  │        ├─ pet_card_test.dart
│  │        └─ search_bar_widget_test.dart

```

## Getting Started

### Prerequisites

- Flutter SDK (^3.6.0 or higher)
- Dart SDK
- Android Studio / VS Code / Cursor
- An Android/iOS device or emulator

### Installation

1. Clone the repository

```bash
git clone https://github.com/KarimSlama/breads.git
```

2.Navigate to project directory

```bash
cd breads
```

3.Install dependencies

```bash
flutter pub get
```

4.Generate code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5.Run the app

```bash
flutter run
```

## Running Tests

### Run all tests

```bash
flutter test
```

### Run unit tests

```bash
flutter test test/unit
```

### Run widget tests

```bash
flutter test test/widget
```

### Run integration tests

```bash
flutter test integration_test
```

## Screenshots


## 👨‍💻 Author

[![Contributors](https://contrib.rocks/image?repo=KarimSlama/testing_all_widgets_flutter)](https://github.com/KarimSlama/testing_all_widgets_flutter/graphs/contributors) **Karim Slama**

- GitHub: [@Karim Slama](https://github.com/KarimSlama)
- LinkedIn: [Karim Slama](https://linkedin.com/in/karim-slama-)
