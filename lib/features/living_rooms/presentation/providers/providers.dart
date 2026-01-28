import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/living_room_datasource.dart';
import '../../data/repositories/living_room_repository_impl.dart';
import '../../domain/repositories/living_room_repository.dart';
import '../../domain/usecases/living_room_usecases.dart';
import '../state/state.dart';

// ============================================================================
// Data Layer Providers
// ============================================================================

/// Provider for living room data source.
///
/// Override this in tests to provide mock data.
final livingRoomDataSourceProvider = Provider<LivingRoomDataSource>((ref) {
  return MockLivingRoomDataSource();
});

/// Provider for living room repository.
final livingRoomRepositoryProvider = Provider<LivingRoomRepository>((ref) {
  final dataSource = ref.watch(livingRoomDataSourceProvider);
  return LivingRoomRepositoryImpl(dataSource: dataSource);
});

// ============================================================================
// Use Case Providers
// ============================================================================

/// Provider for GetLivingRoomsUseCase.
final getLivingRoomsUseCaseProvider = Provider<GetLivingRoomsUseCase>((ref) {
  final repository = ref.watch(livingRoomRepositoryProvider);
  return GetLivingRoomsUseCase(repository);
});

/// Provider for GetLivingRoomByIdUseCase.
final getLivingRoomByIdUseCaseProvider =
    Provider<GetLivingRoomByIdUseCase>((ref) {
  final repository = ref.watch(livingRoomRepositoryProvider);
  return GetLivingRoomByIdUseCase(repository);
});

/// Provider for GetFeaturedLivingRoomsUseCase.
final getFeaturedLivingRoomsUseCaseProvider =
    Provider<GetFeaturedLivingRoomsUseCase>((ref) {
  final repository = ref.watch(livingRoomRepositoryProvider);
  return GetFeaturedLivingRoomsUseCase(repository);
});

/// Provider for SearchLivingRoomsUseCase.
final searchLivingRoomsUseCaseProvider =
    Provider<SearchLivingRoomsUseCase>((ref) {
  final repository = ref.watch(livingRoomRepositoryProvider);
  return SearchLivingRoomsUseCase(repository);
});

// ============================================================================
// State Providers
// ============================================================================

/// Notifier for living rooms list state.
class LivingRoomsNotifier extends StateNotifier<LivingRoomsState> {
  final GetLivingRoomsUseCase _getLivingRoomsUseCase;

  LivingRoomsNotifier(this._getLivingRoomsUseCase)
      : super(const LivingRoomsInitial());

  /// Load all living rooms.
  Future<void> loadLivingRooms() async {
    state = const LivingRoomsLoading();

    final result = await _getLivingRoomsUseCase();

    result.fold(
      (failure) => state = LivingRoomsError(failure),
      (rooms) => state = LivingRoomsLoaded(rooms: rooms),
    );
  }

  /// Filter living rooms by category.
  void filterByCategory(String? category) {
    if (state is LivingRoomsLoaded) {
      final currentState = state as LivingRoomsLoaded;
      state = currentState.copyWith(selectedCategory: category);
    }
  }

  /// Refresh living rooms list.
  Future<void> refresh() async {
    await loadLivingRooms();
  }
}

/// Provider for living rooms state notifier.
final livingRoomsProvider =
    StateNotifierProvider<LivingRoomsNotifier, LivingRoomsState>((ref) {
  final useCase = ref.watch(getLivingRoomsUseCaseProvider);
  return LivingRoomsNotifier(useCase);
});

/// Notifier for living room detail state.
class LivingRoomDetailNotifier extends StateNotifier<LivingRoomDetailState> {
  final GetLivingRoomByIdUseCase _getLivingRoomByIdUseCase;

  LivingRoomDetailNotifier(this._getLivingRoomByIdUseCase)
      : super(const LivingRoomDetailInitial());

  /// Load living room by ID.
  Future<void> loadLivingRoom(String id) async {
    state = const LivingRoomDetailLoading();

    final result = await _getLivingRoomByIdUseCase(id);

    result.fold(
      (failure) => state = LivingRoomDetailError(failure),
      (room) => state = LivingRoomDetailLoaded(livingRoom: room),
    );
  }

  /// Update quantity for the living room.
  void updateQuantity(int quantity) {
    if (state is LivingRoomDetailLoaded) {
      final currentState = state as LivingRoomDetailLoaded;
      state = currentState.copyWith(quantity: quantity);
    }
  }
}

/// Provider for living room detail state notifier (family).
final livingRoomDetailProvider = StateNotifierProvider.family<
    LivingRoomDetailNotifier,
    LivingRoomDetailState,
    String>((ref, roomId) {
  final useCase = ref.watch(getLivingRoomByIdUseCaseProvider);
  return LivingRoomDetailNotifier(useCase);
});