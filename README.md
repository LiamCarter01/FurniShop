# FurniShop - Flutter E-Commerce App

A production-ready Flutter mobile application for a furniture e-commerce shop, built with Clean Architecture principles and designed for scalability and AI-assisted development.

## 🏗️ Architecture

This project follows **Clean Architecture** with a **feature-based folder structure**:

```
lib/
├── main.dart                    # App entry point
├── core/                        # Shared code across features
│   ├── errors/                  # Error handling (failures, exceptions)
│   ├── navigation/              # Routing configuration
│   ├── theme/                   # App theme (colors, typography)
│   └── widgets/                 # Reusable UI components
└── features/                    # Feature modules
    ├── chairs/                  # ✅ Fully implemented reference feature
    │   ├── data/                # Data layer
    │   │   ├── datasources/     # API/remote data sources
    │   │   ├── models/          # Data models (JSON serialization)
    │   │   └── repositories/    # Repository implementations
    │   ├── domain/              # Domain layer
    │   │   ├── entities/        # Business entities
    │   │   ├── repositories/    # Repository interfaces
    │   │   └── usecases/        # Use cases (business logic)
    │   └── presentation/        # Presentation layer
    │       ├── pages/           # Page widgets
    │       ├── providers/       # Riverpod providers
    │       ├── state/           # State classes
    │       └── widgets/         # Feature-specific widgets
    ├── desks/                   # 🚧 Placeholder for implementation
    └── bedrooms/                # 🚧 Placeholder for implementation
```

## 🛠️ Tech Stack

- **Flutter** - UI framework
- **Riverpod** - State management
- **GoRouter** - Navigation
- **Dartz** - Functional programming (Either type)
- **Equatable** - Value equality
- **Dio/HTTP** - Networking
- **Cached Network Image** - Image caching
- **Mocktail** - Testing

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd furnishop

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 📁 Folder Structure Rules

### Core Layer (`lib/core/`)

Contains shared code used across all features:

| Folder | Purpose |
|--------|---------|
| `errors/` | Failure and exception classes |
| `navigation/` | Route definitions and navigation logic |
| `theme/` | Colors, typography, and theme configuration |
| `widgets/` | Reusable UI components (AppButton, ProductCard, etc.) |

### Feature Layer (`lib/features/<feature>/`)

Each feature follows the same three-layer structure:

#### Data Layer (`data/`)
- **datasources/** - Remote/local data sources (API calls)
- **models/** - Data models with JSON serialization
- **repositories/** - Repository implementations

#### Domain Layer (`domain/`)
- **entities/** - Pure business objects
- **repositories/** - Repository interfaces (contracts)
- **usecases/** - Single-purpose business logic classes

#### Presentation Layer (`presentation/`)
- **pages/** - Full-screen widgets
- **providers/** - Riverpod state providers
- **state/** - State classes (sealed classes for state management)
- **widgets/** - Feature-specific UI components

## 🤖 Implementing New Features (AI Guide)

To add a new feature (e.g., `bedrooms`), follow these steps:

### 1. Create Domain Layer

```dart
// lib/features/bedrooms/domain/entities/bedroom_entity.dart
class Bedroom extends Equatable {
  final String id;
  final String name;
  // ... other properties
}

// lib/features/bedrooms/domain/repositories/bedroom_repository.dart
abstract class BedroomRepository {
  Future<Either<Failure, List<Bedroom>>> getBedrooms();
  Future<Either<Failure, Bedroom>> getBedroomById(String id);
}

// lib/features/bedrooms/domain/usecases/bedroom_usecases.dart
class GetBedroomsUseCase {
  final BedroomRepository repository;
  Future<Either<Failure, List<Bedroom>>> call() => repository.getBedrooms();
}
```

### 2. Create Data Layer

```dart
// lib/features/bedrooms/data/models/bedroom_model.dart
class BedroomModel extends Bedroom {
  factory BedroomModel.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}

// lib/features/bedrooms/data/datasources/bedroom_datasource.dart
abstract class BedroomDataSource {
  Future<List<BedroomModel>> getBedrooms();
}

// lib/features/bedrooms/data/repositories/bedroom_repository_impl.dart
class BedroomRepositoryImpl implements BedroomRepository { ... }
```

### 3. Create Presentation Layer

```dart
// lib/features/bedrooms/presentation/state/bedrooms_state.dart
sealed class BedroomsState extends Equatable { ... }
class BedroomsLoading extends BedroomsState { ... }
class BedroomsLoaded extends BedroomsState { ... }
class BedroomsError extends BedroomsState { ... }

// lib/features/bedrooms/presentation/providers/bedrooms_providers.dart
final bedroomsProvider = StateNotifierProvider<BedroomsNotifier, BedroomsState>(...);

// lib/features/bedrooms/presentation/pages/bedrooms_page.dart
class BedroomsPage extends ConsumerWidget { ... }
```

### 4. Register Routes

Update `lib/core/navigation/routes.dart`:

```dart
GoRoute(
  path: AppRoutes.bedrooms,
  name: 'bedrooms',
  builder: (context, state) => const BedroomsPage(),
),
```

## 📋 Code Standards

### State Management

Use sealed classes for exhaustive state handling:

```dart
sealed class ChairsState extends Equatable { ... }

// In widget:
Widget build(context) {
  return switch (state) {
    ChairsInitial() => const LoadingWidget(),
    ChairsLoading() => const LoadingWidget(),
    ChairsLoaded(:final chairs) => ChairGrid(chairs: chairs),
    ChairsError(:final message) => ErrorWidget(message: message),
  };
}
```

### Error Handling

Use `Either<Failure, T>` from dartz for error handling:

```dart
Future<Either<Failure, List<Chair>>> getChairs() async {
  try {
    final chairs = await dataSource.getChairs();
    return Right(chairs);
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  }
}
```

### Dependency Injection

Use Riverpod providers for dependency injection:

```dart
final chairRepositoryProvider = Provider<ChairRepository>((ref) {
  final dataSource = ref.watch(chairDataSourceProvider);
  return ChairRepositoryImpl(dataSource: dataSource);
});
```

## 🎨 Using Core Widgets

### AppButton

```dart
AppButton(
  label: 'Add to Cart',
  onPressed: () => addToCart(),
  variant: AppButtonVariant.accent,
  size: AppButtonSize.medium,
  leadingIcon: Icons.shopping_cart,
  isLoading: isLoading,
)
```

### ProductCard

```dart
ProductCard(
  name: 'Modern Chair',
  description: 'Comfortable office chair',
  price: 299.99,
  originalPrice: 399.99,
  imageUrl: 'https://example.com/chair.jpg',
  rating: 4.5,
  reviewCount: 100,
  onTap: () => navigateToDetails(),
  onAddToCart: () => addToCart(),
  onWishlistToggle: () => toggleWishlist(),
)
```

### AppText

```dart
AppText(
  text: 'Welcome',
  variant: AppTextVariant.headlineMedium,
  color: AppColors.textPrimary,
)

// Or use convenience methods
AppText.price(amount: 99.99)
AppText.originalPrice(amount: 129.99)
```

## 📦 Export Conventions

Each folder should have an export file:

```dart
// lib/features/chairs/domain/entities/entities.dart
library;
export 'chair_entity.dart';
```

## ✅ Testing

Tests mirror the lib structure:

```
test/
├── core/
│   └── widgets/
│       ├── app_button_test.dart
│       └── product_card_test.dart
└── features/
    └── chairs/
        ├── data/
        │   └── repositories/
        │       └── chair_repository_impl_test.dart
        ├── domain/
        │   └── usecases/
        │       └── chair_usecases_test.dart
        └── presentation/
            └── pages/
                └── chairs_page_test.dart
```

## 📝 License

This project is licensed under the MIT License.
