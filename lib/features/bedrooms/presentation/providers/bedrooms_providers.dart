import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/bedrooms_state.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// Provider for the bedroom data source.
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

/// Provider for the bedroom repository.
final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use Case Providers
// ============================================================================

/// Provider for getting all bedrooms.
final getBedroomsUseCaseProvider = Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

/// Provider for getting a bedroom by ID.
final getBedroomByIdUseCaseProvider =
    Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

/// Provider for getting featured bedrooms.
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
// State Providers
// ============================================================================

/// Notifier for bedrooms list states.
class BedroomsNotifier extends StateNotifier<BedroomsState> {
  final GetBedroomsUseCase _getBedroomsUseCase;

  BedroomsNotifier(this._getBedroomsUseCase) : super(const BedroomsInitial());

  /// Load bedroom catalog.
  Future<void> loadBedrooms() async {
    state = const BedroomsLoading();

    final result = await _getBedroomsUseCase();

    result.fold(
      (failure) => state = BedroomsError(failure),
      (bedrooms) => state = BedroomsLoaded(bedrooms: bedrooms),
    );
  }

  /// Filter bedrooms by category.
  void filterByCategory(String? category) {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = currentState.copyWith(selectedCategory: category);
    }
  }

  /// Clear the active category filter.
  void clearFilter() {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = BedroomsLoaded(
        bedrooms: currentState.bedrooms,
        selectedCategory: null,
      );
    }
  }

  /// Refresh bedroom list by reloading data.
  Future<void> refresh() async {
    await loadBedrooms();
  }
}

/// Provider for the bedrooms list notifier.
final bedroomsProvider = StateNotifierProvider<BedroomsNotifier, BedroomsState>((ref) {
  final getBedroomsUseCase = ref.watch(getBedroomsUseCaseProvider);
  return BedroomsNotifier(getBedroomsUseCase);
});

/// Notifier for bedroom detail state.
class BedroomDetailNotifier extends StateNotifier<BedroomDetailState> {
  final GetBedroomByIdUseCase _getBedroomByIdUseCase;

  BedroomDetailNotifier(this._getBedroomByIdUseCase)
      : super(const BedroomDetailInitial());

  /// Load bedroom detail by ID.
  Future<void> loadBedroom(String id) async {
    state = const BedroomDetailLoading();

    final result = await _getBedroomByIdUseCase(id);

    result.fold(
      (failure) => state = BedroomDetailError(failure),
      (bedroom) => state = BedroomDetailLoaded(bedroom: bedroom),
    );
  }

  /// Update selected quantity (must be positive).
  void updateQuantity(int quantity) {
    if (state is BedroomDetailLoaded && quantity > 0) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  /// Increase quantity by one.
  void incrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  /// Decrease quantity by one (minimum of one).
  void decrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

/// Provider for bedroom detail notifier.
final bedroomDetailProvider = StateNotifierProvider.family<
    BedroomDetailNotifier,
    BedroomDetailState,
    String>((ref, bedroomId) {
  final getBedroomByIdUseCase = ref.watch(getBedroomByIdUseCaseProvider);
  return BedroomDetailNotifier(getBedroomByIdUseCase);
});