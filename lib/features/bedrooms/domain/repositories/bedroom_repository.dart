import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data operations.
///
/// This defines the contract for bedrooms so the domain layer remains decoupled
/// from the data implementation.
abstract class BedroomRepository {
  /// Get all bedrooms.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Get a single bedroom by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Filter bedrooms by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);

  /// Get featured bedrooms.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
