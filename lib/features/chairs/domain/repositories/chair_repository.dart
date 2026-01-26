import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chair_entity.dart';

/// Repository interface for chair data operations.
///
/// This defines the contract for chair data access.
/// Implementation is in the data layer.
abstract class ChairRepository {
  /// Get all chairs.
  ///
  /// Returns [Right] with list of chairs on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Chair>>> getChairs();

  /// Get a single chair by ID.
  ///
  /// Returns [Right] with chair on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, Chair>> getChairById(String id);

  /// Get chairs by category.
  ///
  /// [category] - The category to filter by.
  /// Returns [Right] with filtered list on success.
  Future<Either<Failure, List<Chair>>> getChairsByCategory(String category);

  /// Get featured chairs.
  ///
  /// Returns [Right] with featured chairs on success.
  Future<Either<Failure, List<Chair>>> getFeaturedChairs();

  /// Search chairs by query.
  ///
  /// [query] - Search query string.
  /// Returns [Right] with matching chairs on success.
  Future<Either<Failure, List<Chair>>> searchChairs(String query);
}
