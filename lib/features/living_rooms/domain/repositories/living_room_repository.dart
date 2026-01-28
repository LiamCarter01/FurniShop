import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/living_room_entity.dart';

/// Repository interface for living room data operations.
///
/// This defines the contract for living room data access.
/// Implementation is in the data layer.
abstract class LivingRoomRepository {
  /// Get all living rooms.
  ///
  /// Returns [Right] with list of living rooms on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<LivingRoom>>> getLivingRooms();

  /// Get a single living room by ID.
  ///
  /// Returns [Right] with living room on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, LivingRoom>> getLivingRoomById(String id);

  /// Get living rooms by category.
  ///
  /// [category] - The category to filter by.
  /// Returns [Right] with filtered list on success.
  Future<Either<Failure, List<LivingRoom>>> getLivingRoomsByCategory(String category);

  /// Get featured living rooms.
  ///
  /// Returns [Right] with featured living rooms on success.
  Future<Either<Failure, List<LivingRoom>>> getFeaturedLivingRooms();

  /// Search living rooms by query.
  ///
  /// [query] - Search query string.
  /// Returns [Right] with matching living rooms on success.
  Future<Either<Failure, List<LivingRoom>>> searchLivingRooms(String query);
}
