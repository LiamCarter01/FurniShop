import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data operations.
///
/// Defines the contract between the domain and data layers for bedrooms.
abstract class BedroomRepository {
  /// Fetch all bedrooms.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Fetch a single bedroom by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Fetch bedrooms filtered by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);

  /// Fetch featured bedrooms.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms by query.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
