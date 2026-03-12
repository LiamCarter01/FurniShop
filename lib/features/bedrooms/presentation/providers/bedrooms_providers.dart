import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/bedrooms_state.dart';

/// Data layer provider for bedroom data source.
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

/// Data layer provider for bedroom repository.
final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

/// Use case provider for fetching all bedrooms.
final getBedroomsUseCaseProvider = Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

/// Use case provider for fetching a single bedroom by ID.
final getBedroomByIdUseCaseProvider = Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

/// Use case provider for fetching featured bedrooms.
final getFeaturedBedroomsUseCaseProvider =
    Provider<GetFeaturedBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetFeaturedBedroomsUseCase(repository);
});

/// Use case provider for searching bedrooms.
final searchBedroomsUseCaseProvider = Provider<SearchBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return SearchBedroomsUseCase(repository);
});

/// State notifier for the bedrooms list page.
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

  /// Refresh the bedroom list.
  Future<void> refresh() async {
    await loadBedrooms();
  }
}

/// Provider for the bedrooms state notifier.
final bedroomsProvider =
    StateNotifierProvider<BedroomsNotifier, BedroomsState>((ref) {
  final useCase = ref.watch(getBedroomsUseCaseProvider);
  return BedroomsNotifier(useCase);
});
