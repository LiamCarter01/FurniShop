import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/desk_datasource.dart';
import '../../data/repositories/desk_repository_impl.dart';
import '../../domain/repositories/desk_repository.dart';
import '../../domain/usecases/desk_usecases.dart';
import '../state/desks_state.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// Provider for desk data source.
final deskDataSourceProvider = Provider<DeskDataSource>((ref) {
  return MockDeskDataSource();
});

/// Provider for desk repository.
final deskRepositoryProvider = Provider<DeskRepository>((ref) {
  final dataSource = ref.watch(deskDataSourceProvider);
  return DeskRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use Case Providers
// ============================================================================

/// Provider for GetDesksUseCase.
final getDesksUseCaseProvider = Provider<GetDesksUseCase>((ref) {
  final repository = ref.watch(deskRepositoryProvider);
  return GetDesksUseCase(repository);
});

/// Provider for GetDeskByIdUseCase.
final getDeskByIdUseCaseProvider = Provider<GetDeskByIdUseCase>((ref) {
  final repository = ref.watch(deskRepositoryProvider);
  return GetDeskByIdUseCase(repository);
});

/// Provider for GetFeaturedDesksUseCase.
final getFeaturedDesksUseCaseProvider =
    Provider<GetFeaturedDesksUseCase>((ref) {
  final repository = ref.watch(deskRepositoryProvider);
  return GetFeaturedDesksUseCase(repository);
});

/// Provider for SearchDesksUseCase.
final searchDesksUseCaseProvider = Provider<SearchDesksUseCase>((ref) {
  final repository = ref.watch(deskRepositoryProvider);
  return SearchDesksUseCase(repository);
});

// ============================================================================
// State Providers
// ============================================================================

/// Notifier for desks list state.
class DesksNotifier extends StateNotifier<DesksState> {
  final GetDesksUseCase _getDesksUseCase;

  DesksNotifier(this._getDesksUseCase) : super(const DesksInitial());

  /// Load all desks.
  Future<void> loadDesks() async {
    state = const DesksLoading();

    final result = await _getDesksUseCase();

    result.fold(
      (failure) => state = DesksError(failure),
      (desks) => state = DesksLoaded(desks: desks),
    );
  }

  /// Filter desks by category.
  void filterByCategory(String? category) {
    if (state is DesksLoaded) {
      final currentState = state as DesksLoaded;
      state = currentState.copyWith(selectedCategory: category);
    }
  }

  /// Clear category filter.
  void clearFilter() {
    if (state is DesksLoaded) {
      final currentState = state as DesksLoaded;
      state = DesksLoaded(
        desks: currentState.desks,
        selectedCategory: null,
      );
    }
  }

  /// Refresh desks list.
  Future<void> refresh() async {
    await loadDesks();
  }
}

/// Provider for desks state notifier.
final desksProvider = StateNotifierProvider<DesksNotifier, DesksState>(
  (ref) {
    final getDesksUseCase = ref.watch(getDesksUseCaseProvider);
    return DesksNotifier(getDesksUseCase);
  },
);

/// Notifier for desk detail state.
class DeskDetailNotifier extends StateNotifier<DeskDetailState> {
  final GetDeskByIdUseCase _getDeskByIdUseCase;

  DeskDetailNotifier(this._getDeskByIdUseCase)
      : super(const DeskDetailInitial());

  /// Load desk by ID.
  Future<void> loadDesk(String id) async {
    state = const DeskDetailLoading();

    final result = await _getDeskByIdUseCase(id);

    result.fold(
      (failure) => state = DeskDetailError(failure),
      (desk) => state = DeskDetailLoaded(desk: desk),
    );
  }

  /// Update quantity.
  void updateQuantity(int quantity) {
    if (state is DeskDetailLoaded && quantity > 0) {
      final currentState = state as DeskDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  /// Increment quantity.
  void incrementQuantity() {
    if (state is DeskDetailLoaded) {
      final currentState = state as DeskDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  /// Decrement quantity.
  void decrementQuantity() {
    if (state is DeskDetailLoaded) {
      final currentState = state as DeskDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

/// Provider for desk detail state notifier.
///
/// Family provider allows creating separate instances per desk ID.
final deskDetailProvider =
    StateNotifierProvider.family<DeskDetailNotifier, DeskDetailState, String>(
  (ref, deskId) {
    final getDeskByIdUseCase = ref.watch(getDeskByIdUseCaseProvider);
    return DeskDetailNotifier(getDeskByIdUseCase);
  },
);