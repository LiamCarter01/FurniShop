import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom-related data operations.
///
/// Defines the contract implemented by the data layer.
abstract class BedroomRepository {
  /// Fetch all bedroom products.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Fetch a specific bedroom product by ID.
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Fetch bedroom products filtered by category.
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);

  /// Fetch featured bedroom products.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Search bedroom products by a query string.
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
