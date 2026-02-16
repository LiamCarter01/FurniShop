import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';

/// Repository contract for bedroom data operations.
abstract class BedroomRepository {
  Future<Either<Failure, List<Bedroom>>> getBedrooms();
  Future<Either<Failure, Bedroom>> getBedroomById(String id);
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(String category);
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms();
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query);
}
