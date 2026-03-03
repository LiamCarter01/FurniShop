import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';
import '../repositories/bedroom_repository.dart';

/// Use case for fetching all bedrooms.
class GetBedroomsUseCase {
  final BedroomRepository repository;

  const GetBedroomsUseCase(this.repository);

  /// Executes the use case.
  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getBedrooms();
  }
}

/// Use case for fetching a bedroom by its identifier.
class GetBedroomByIdUseCase {
  final BedroomRepository repository;

  const GetBedroomByIdUseCase(this.repository);

  /// Executes the use case with [id].
  Future<Either<Failure, Bedroom>> call(String id) async {
    return repository.getBedroomById(id);
  }
}

/// Use case for fetching bedrooms filtered by category.
class GetBedroomsByCategoryUseCase {
  final BedroomRepository repository;

  const GetBedroomsByCategoryUseCase(this.repository);

  /// Executes the use case with [category].
  Future<Either<Failure, List<Bedroom>>> call(String category) async {
    return repository.getBedroomsByCategory(category);
  }
}

/// Use case for fetching featured bedrooms.
class GetFeaturedBedroomsUseCase {
  final BedroomRepository repository;

  const GetFeaturedBedroomsUseCase(this.repository);

  /// Executes the use case.
  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getFeaturedBedrooms();
  }
}

/// Use case for searching bedrooms.
class SearchBedroomsUseCase {
  final BedroomRepository repository;

  const SearchBedroomsUseCase(this.repository);

  /// Executes the use case with [query].
  Future<Either<Failure, List<Bedroom>>> call(String query) async {
    return repository.searchBedrooms(query);
  }
}
