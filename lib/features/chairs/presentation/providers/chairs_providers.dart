import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/chair_datasource.dart';
import '../../data/repositories/chair_repository_impl.dart';
import '../../domain/repositories/chair_repository.dart';
import '../../domain/usecases/chair_usecases.dart';
import '../state/chairs_state.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// Provider for chair data source.
///
/// Override this in tests to provide mock data.
final chairDataSourceProvider = Provider<ChairDataSource>((ref) {
  return MockChairDataSource();
});

/// Provider for chair repository.
final chairRepositoryProvider = Provider<ChairRepository>((ref) {
  final dataSource = ref.watch(chairDataSourceProvider);
  return ChairRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use Case Providers
// ============================================================================

/// Provider for GetChairsUseCase.
final getChairsUseCaseProvider = Provider<GetChairsUseCase>((ref) {
  final repository = ref.watch(chairRepositoryProvider);
  return GetChairsUseCase(repository);
});

/// Provider for GetChairByIdUseCase.
final getChairByIdUseCaseProvider = Provider<GetChairByIdUseCase>((ref) {
  final repository = ref.watch(chairRepositoryProvider);
  return GetChairByIdUseCase(repository);
});

/// Provider for GetFeaturedChairsUseCase.
final getFeaturedChairsUseCaseProvider =
    Provider<GetFeaturedChairsUseCase>((ref) {
  final repository = ref.watch(chairRepositoryProvider);
  return GetFeaturedChairsUseCase(repository);
});

/// Provider for SearchChairsUseCase.
final searchChairsUseCaseProvider = Provider<SearchChairsUseCase>((ref) {
  final repository = ref.watch(chairRepositoryProvider);
  return SearchChairsUseCase(repository);
});

// ============================================================================
// State Providers
// ============================================================================

/// Notifier for chairs list state.
class ChairsNotifier extends StateNotifier<ChairsState> {
  final GetChairsUseCase _getChairsUseCase;

  ChairsNotifier(this._getChairsUseCase) : super(const ChairsInitial());

  /// Load all chairs.
  Future<void> loadChairs() async {
    state = const ChairsLoading();

    final result = await _getChairsUseCase();

    result.fold(
      (failure) => state = ChairsError(failure),
      (chairs) => state = ChairsLoaded(chairs: chairs),
    );
  }

  /// Filter chairs by category.
  void filterByCategory(String? category) {
    if (state is ChairsLoaded) {
      final currentState = state as ChairsLoaded;
      state = currentState.copyWith(
        selectedCategory: category,
      );
    }
  }

  /// Clear category filter.
  void clearFilter() {
    if (state is ChairsLoaded) {
      final currentState = state as ChairsLoaded;
      state = ChairsLoaded(
        chairs: currentState.chairs,
        selectedCategory: null,
      );
    }
  }

  /// Refresh chairs list.
  Future<void> refresh() async {
    await loadChairs();
  }
}

/// Provider for chairs state notifier.
final chairsProvider = StateNotifierProvider<ChairsNotifier, ChairsState>(
  (ref) {
    final getChairsUseCase = ref.watch(getChairsUseCaseProvider);
    return ChairsNotifier(getChairsUseCase);
  },
);

/// Notifier for chair detail state.
class ChairDetailNotifier extends StateNotifier<ChairDetailState> {
  final GetChairByIdUseCase _getChairByIdUseCase;

  ChairDetailNotifier(this._getChairByIdUseCase)
      : super(const ChairDetailInitial());

  /// Load chair by ID.
  Future<void> loadChair(String id) async {
    state = const ChairDetailLoading();

    final result = await _getChairByIdUseCase(id);

    result.fold(
      (failure) => state = ChairDetailError(failure),
      (chair) => state = ChairDetailLoaded(chair: chair),
    );
  }

  /// Update quantity.
  void updateQuantity(int quantity) {
    if (state is ChairDetailLoaded && quantity > 0) {
      final currentState = state as ChairDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  /// Increment quantity.
  void incrementQuantity() {
    if (state is ChairDetailLoaded) {
      final currentState = state as ChairDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  /// Decrement quantity.
  void decrementQuantity() {
    if (state is ChairDetailLoaded) {
      final currentState = state as ChairDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

/// Provider for chair detail state notifier.
///
/// Family provider allows creating separate instances per chair ID.
final chairDetailProvider =
    StateNotifierProvider.family<ChairDetailNotifier, ChairDetailState, String>(
  (ref, chairId) {
    final getChairByIdUseCase = ref.watch(getChairByIdUseCaseProvider);
    return ChairDetailNotifier(getChairByIdUseCase);
  },
);
