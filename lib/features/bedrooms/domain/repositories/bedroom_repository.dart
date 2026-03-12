import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom data operations.
///
/// This defines the contract for bedroom data access.
/// Implementation is provided in the data layer.
abstract class BedroomRepository {
  /// Get all bedroom products.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Get a single bedroom product by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Get bedroom products by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(
      String category);

  /// Get featured bedroom products.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedrooms by query.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
