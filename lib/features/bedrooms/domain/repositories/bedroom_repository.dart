import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data access.
///
/// Implementations belong to the data layer.
abstract class BedroomRepository {
  /// Get all bedrooms.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Get a single bedroom by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Get bedrooms filtered by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(
    String category,
  );

  /// Get featured bedrooms.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms by query.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
