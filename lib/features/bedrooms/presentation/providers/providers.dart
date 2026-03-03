import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/state.dart';

// ============================================================================
// Data layer providers
// ============================================================================

/// Provides the bedroom data source (mocked for now).
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

/// Provides the bedroom repository implementation.
final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use case providers
// ============================================================================

/// Provider for fetching the complete bedroom catalog.
final getBedroomsUseCaseProvider = Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

/// Provider for fetching bedroom detail by ID.
final getBedroomByIdUseCaseProvider = Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

/// Provider for fetching featured bedrooms.
final getFeaturedBedroomsUseCaseProvider =
    Provider<GetFeaturedBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetFeaturedBedroomsUseCase(repository);
});

/// Provider for searching bedrooms.
final searchBedroomsUseCaseProvider = Provider<SearchBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return SearchBedroomsUseCase(repository);
});

// ============================================================================
// Presentation state providers
// ============================================================================

/// Notifier managing the bedrooms list state.
class BedroomsNotifier extends StateNotifier<BedroomsState> {
  final GetBedroomsUseCase _getBedroomsUseCase;

  BedroomsNotifier(this._getBedroomsUseCase) : super(const BedroomsInitial());

  /// Loads all bedrooms.
  Future<void> loadBedrooms() async {
    state = const BedroomsLoading();

    final result = await _getBedroomsUseCase();

    result.fold(
      (failure) => state = BedroomsError(failure),
      (bedrooms) => state = BedroomsLoaded(bedrooms: bedrooms),
    );
  }

  /// Filters bedrooms by category.
  void filterByCategory(String? category) {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = currentState.copyWith(selectedCategory: category);
    }
  }

  /// Clears any active category filter.
  void clearFilter() {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = BedroomsLoaded(
        bedrooms: currentState.bedrooms,
        selectedCategory: null,
      );
    }
  }

  /// Refreshes the bedroom list.
  Future<void> refresh() async {
    await loadBedrooms();
  }
}

/// State notifier provider for the bedrooms list.
final bedroomsProvider = StateNotifierProvider<BedroomsNotifier, BedroomsState>(
  (ref) {
    final useCase = ref.watch(getBedroomsUseCaseProvider);
    return BedroomsNotifier(useCase);
  },
);

/// Notifier for bedroom detail state.
class BedroomDetailNotifier extends StateNotifier<BedroomDetailState> {
  final GetBedroomByIdUseCase _getBedroomByIdUseCase;

  BedroomDetailNotifier(this._getBedroomByIdUseCase)
      : super(const BedroomDetailInitial());

  /// Loads a specific bedroom by ID.
  Future<void> loadBedroom(String id) async {
    state = const BedroomDetailLoading();

    final result = await _getBedroomByIdUseCase(id);

    result.fold(
      (failure) => state = BedroomDetailError(failure),
      (bedroom) => state = BedroomDetailLoaded(bedroom: bedroom),
    );
  }

  /// Updates the selected quantity for the detail view.
  void updateQuantity(int quantity) {
    if (state is BedroomDetailLoaded && quantity > 0) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  /// Increments the quantity.
  void incrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  /// Decrements the quantity while keeping it above zero.
  void decrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

/// Detail provider for bedrooms where each bedroom ID gets its own notifier.
final bedroomDetailProvider =
    StateNotifierProvider.family<BedroomDetailNotifier, BedroomDetailState, String>(
  (ref, bedroomId) {
    final useCase = ref.watch(getBedroomByIdUseCaseProvider);
    return BedroomDetailNotifier(useCase);
  },
);
