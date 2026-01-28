import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/desk_entity.dart';

/// Repository interface for desk data operations.
///
/// This defines the contract for desk data access.
/// Implementation is in the data layer.
abstract class DeskRepository {
  /// Get all desks.
  ///
  /// Returns [Right] with list of desks on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Desk>>> getDesks();

  /// Get a single desk by ID.
  ///
  /// Returns [Right] with desk on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, Desk>> getDeskById(String id);

  /// Get desks by category.
  ///
  /// [category] - The category to filter by.
  /// Returns [Right] with filtered list on success.
  Future<Either<Failure, List<Desk>>> getDesksByCategory(String category);

  /// Get featured desks.
  ///
  /// Returns [Right] with featured desks on success.
  Future<Either<Failure, List<Desk>>> getFeaturedDesks();

  /// Search desks by query.
  ///
  /// [query] - Search query string.
  /// Returns [Right] with matching desks on success.
  Future<Either<Failure, List<Desk>>> searchDesks(String query);
}
