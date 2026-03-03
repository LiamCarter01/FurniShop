import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository interface for bedroom operations.
///
/// The implementation lives in the data layer and maps exceptions to failures.
abstract class BedroomRepository {
  /// Fetches all bedroom products.
  Future<Either<Failure, List<Bedroom>>> getBedrooms();

  /// Loads a bedroom product by [id].
  Future<Either<Failure, Bedroom>> getBedroomById(String id);

  /// Loads bedrooms that belong to [category].
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);

  /// Fetches highlighted bedroom products.
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();

  /// Searches bedrooms matching the [query].
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
