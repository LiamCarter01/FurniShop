import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/bedroom_datasource.dart';
import '../../data/repositories/bedroom_repository_impl.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../../domain/usecases/bedroom_usecases.dart';
import '../state/bedrooms_state.dart';

/// Data layer providers
final bedroomDataSourceProvider = Provider<BedroomDataSource>((ref) {
  return MockBedroomDataSource();
});

final bedroomRepositoryProvider = Provider<BedroomRepository>((ref) {
  final dataSource = ref.watch(bedroomDataSourceProvider);
  return BedroomRepositoryImpl(dataSource: dataSource);
});

/// Use case providers
final getBedroomsUseCaseProvider = Provider<GetBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomsUseCase(repository);
});

final getBedroomByIdUseCaseProvider = Provider<GetBedroomByIdUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetBedroomByIdUseCase(repository);
});

final getFeaturedBedroomsUseCaseProvider =
    Provider<GetFeaturedBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return GetFeaturedBedroomsUseCase(repository);
});

final searchBedroomsUseCaseProvider = Provider<SearchBedroomsUseCase>((ref) {
  final repository = ref.watch(bedroomRepositoryProvider);
  return SearchBedroomsUseCase(repository);
});

/// State notifier for bedrooms list
class BedroomsNotifier extends StateNotifier<BedroomsState> {
  final GetBedroomsUseCase _getBedroomsUseCase;

  BedroomsNotifier(this._getBedroomsUseCase) : super(const BedroomsInitial());

  Future<void> loadBedrooms() async {
    state = const BedroomsLoading();

    final result = await _getBedroomsUseCase();

    result.fold(
      (failure) => state = BedroomsError(failure),
      (bedrooms) => state = BedroomsLoaded(bedrooms: bedrooms),
    );
  }

  void filterByCategory(String? category) {
    if (state is BedroomsLoaded) {
      final currentState = state as BedroomsLoaded;
      state = currentState.copyWith(selectedCategory: category);
    }
  }

  Future<void> refresh() async {
    await loadBedrooms();
  }
}

final bedroomsProvider =
    StateNotifierProvider<BedroomsNotifier, BedroomsState>((ref) {
  final useCase = ref.watch(getBedroomsUseCaseProvider);
  return BedroomsNotifier(useCase);
});

/// State notifier for bedroom detail view
class BedroomDetailNotifier extends StateNotifier<BedroomDetailState> {
  final GetBedroomByIdUseCase _getBedroomByIdUseCase;

  BedroomDetailNotifier(this._getBedroomByIdUseCase)
      : super(const BedroomDetailInitial());

  Future<void> loadBedroom(String id) async {
    state = const BedroomDetailLoading();

    final result = await _getBedroomByIdUseCase(id);

    result.fold(
      (failure) => state = BedroomDetailError(failure),
      (bedroom) => state = BedroomDetailLoaded(bedroom: bedroom),
    );
  }

  void updateQuantity(int quantity) {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }

  void incrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      state = currentState.copyWith(quantity: currentState.quantity + 1);
    }
  }

  void decrementQuantity() {
    if (state is BedroomDetailLoaded) {
      final currentState = state as BedroomDetailLoaded;
      if (currentState.quantity > 1) {
        state = currentState.copyWith(quantity: currentState.quantity - 1);
      }
    }
  }
}

final bedroomDetailProvider = StateNotifierProvider.family<
    BedroomDetailNotifier,
    BedroomDetailState,
    String>((ref, bedroomId) {
  final useCase = ref.watch(getBedroomByIdUseCaseProvider);
  return BedroomDetailNotifier(useCase);
});
