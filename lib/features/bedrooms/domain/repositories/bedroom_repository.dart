import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data operations.
///
/// This defines the contract for bedroom data access.
/// Implementation is in the data layer.
abstract class BedroomRepository {
  /// Get all bedrooms.
  ///
  /// Returns [Right] with list of bedrooms on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Get a single bedroom by ID.
  ///
  /// Returns [Right] with bedroom on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Get bedrooms by category.
  ///
  /// [category] - The category to filter by.
  /// Returns [Right] with filtered list on success.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);

  /// Get featured bedrooms.
  ///
  /// Returns [Right] with featured bedrooms on success.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms by query.
  ///
  /// [query] - Search query string.
  /// Returns [Right] with matching bedrooms on success.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
