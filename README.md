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
- **Testing**: Flutter Test, Mockito
- **Code Generation**: Build Runner, Json Serializable, Injectable

## Project Structure

```

breads
├─ assets
│  ├─ icons
│  └─ images
│     └─ logo.png
├─ flutter_native_splash.yaml
├─ lib
│  ├─ breads
│  │  └─ onboarding
│  │     └─ onboarding_screen.dart
│  ├─ breads_app.dart
│  ├─ core
│  │  ├─ common
│  │  │  ├─ local
│  │  │  └─ widgets
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
│  └─ main.dart
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md

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
