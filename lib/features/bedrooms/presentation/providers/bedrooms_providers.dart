import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/bedrooms_state.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// Provider for bedroom data source.
///
/// Override in tests to provide custom data.
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

/// Provider for bedroom repository.
final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use Case Providers
// ============================================================================

/// Provider for [GetBedroomsUseCase].
final getBedroomsUseCaseProvider =
    Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

/// Provider for [GetBedroomsByCategoryUseCase].
final getBedroomsByCategoryUseCaseProvider =
    Provider<GetBedroomsByCategoryUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsByCategoryUseCase(repository);
});

/// Provider for [SearchBedroomsUseCase].
final searchBedroomsUseCaseProvider =
    Provider<SearchBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return SearchBedroomsUseCase(repository);
});

/// Provider for [GetBedroomByIdUseCase].
final getBedroomByIdUseCaseProvider =
    Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

/// Provider for [GetFeaturedBedroomsUseCase].
final getFeaturedBedroomsUseCaseProvider =
    Provider<GetFeaturedBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetFeaturedBedroomsUseCase(repository);
});

// ============================================================================
// State Providers
// ============================================================================

/// Notifier for bedrooms list state.
class BedroomsNotifier extends StateNotifier<BedroomsState> {
  final GetBedroomsUseCase _getBedroomsUseCase;

  BedroomsNotifier(this._getBedroomsUseCase)
      : super(const BedroomsInitial());

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

  /// Refresh bedroom catalog.
  Future<void> refresh() async {
    await loadBedrooms();
  }
}

/// Provider for bedrooms list state notifier.
final bedroomsProvider = StateNotifierProvider<BedroomsNotifier, BedroomsState>((ref) {
  final useCase = ref.watch(getBedroomsUseCaseProvider);
  return BedroomsNotifier(useCase);
});
