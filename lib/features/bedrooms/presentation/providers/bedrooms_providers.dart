import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/bedrooms_state.dart';

/// Provider for bedroom data source implementation.
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

/// Provider for bedroom repository implementation.
final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

/// Use case provider for fetching bedrooms.
final getBedroomsUseCaseProvider = Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

/// Use case provider for single bedroom fetch.
final getBedroomByIdUseCaseProvider =
    Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

/// Use case provider for featured bedrooms.
final getFeaturedBedroomsUseCaseProvider = Provider<GetFeaturedBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetFeaturedBedroomsUseCase(repository);
});

/// Use case provider for searching bedrooms.
final searchBedroomsUseCaseProvider = Provider<SearchBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return SearchBedroomsUseCase(repository);
});

/// State notifier managing the bedrooms list.
class BedroomsNotifier extends StateNotifier<BedroomsState> {
  final GetBedroomsUseCase _getBedroomsUseCase;

  BedroomsNotifier(this._getBedroomsUseCase) : super(const BedroomsInitial());

  /// Load all bedrooms.
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

  /// Clear the current category filter.
  void clearFilter() {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = BedroomsLoaded(
        bedrooms: currentState.bedrooms,
        selectedCategory: null,
      );
    }
  }

  /// Refresh the bedrooms list.
  Future<void> refresh() async {
    await loadBedrooms();
  }
}

/// Provider exposing the bedrooms state notifier.
final bedroomsProvider =
    StateNotifierProvider<BedroomsNotifier, BedroomsState>((ref) {
  final getBedroomsUseCase = ref.watch(getBedroomsUseCaseProvider);
  return BedroomsNotifier(getBedroomsUseCase);
});

/// State notifier managing bedroom detail state.
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

  /// Update quantity for the bedroom detail view.
  void updateQuantity(int quantity) {
    if (state is BedroomDetailLoaded && quantity > 0) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  /// Increment quantity.
  void incrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  /// Decrement quantity.
  void decrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

/// Provider for the bedroom detail state notifier.
final bedroomDetailProvider =
    StateNotifierProvider.family<BedroomDetailNotifier, BedroomDetailState, String>(
  (ref, bedroomId) {
    final getBedroomByIdUseCase = ref.watch(getBedroomByIdUseCaseProvider);
    return BedroomDetailNotifier(getBedroomByIdUseCase);
  },
);
