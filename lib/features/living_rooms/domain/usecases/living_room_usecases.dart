import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/living_room_entity.dart';
import '../repositories/living_room_repository.dart';

/// Use case for getting all living rooms.
///
/// This follows the Clean Architecture use case pattern.
/// It encapsulates a single business action.
class GetLivingRoomsUseCase {
  final LivingRoomRepository repository;

  const GetLivingRoomsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// Returns [Right] with list of living rooms on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<LivingRoom>>> call() async {
    return repository.getLivingRooms();
  }
}

/// Use case for getting a single living room by ID.
class GetLivingRoomByIdUseCase {
  final LivingRoomRepository repository;

  const GetLivingRoomByIdUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [id] - The living room ID to fetch.
  Future<Either<Failure, LivingRoom>> call(String id) async {
    return repository.getLivingRoomById(id);
  }
}

/// Use case for getting living rooms by category.
class GetLivingRoomsByCategoryUseCase {
  final LivingRoomRepository repository;

  const GetLivingRoomsByCategoryUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [category] - The category to filter by.
  Future<Either<Failure, List<LivingRoom>>> call(String category) async {
    return repository.getLivingRoomsByCategory(category);
  }
}

/// Use case for getting featured living rooms.
class GetFeaturedLivingRoomsUseCase {
  final LivingRoomRepository repository;

  const GetFeaturedLivingRoomsUseCase(this.repository);

  /// Execute the use case.
  Future<Either<Failure, List<LivingRoom>>> call() async {
    return repository.getFeaturedLivingRooms();
  }
}

/// Use case for searching living rooms.
class SearchLivingRoomsUseCase {
  final LivingRoomRepository repository;

  const SearchLivingRoomsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [query] - Search query string.
  Future<Either<Failure, List<LivingRoom>>> call(String query) async {
    return repository.searchLivingRooms(query);
  }
}
