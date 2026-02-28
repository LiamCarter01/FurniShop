import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data operations.
///
/// Defines the contract for bedrooms data access.
abstract class BedroomRepository {
  /// Retrieve all bedrooms products.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Retrieve a single bedroom product by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Retrieve bedrooms filtered by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(
      String category);

  /// Retrieve featured bedrooms.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms by query string.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
