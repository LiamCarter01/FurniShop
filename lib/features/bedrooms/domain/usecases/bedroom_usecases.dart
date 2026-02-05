import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';
import '../repositories/bedroom_repository.dart';

/// Use case for getting all bedrooms.
///
/// It encapsulates a single business action.
class GetBedroomsUseCase {
  final BedroomRepository repository;

  const GetBedroomsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// Returns [Right] with list of bedrooms on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getBedrooms();
  }
}

/// Use case for getting a single bedroom by ID.
class GetBedroomByIdUseCase {
  final BedroomRepository repository;

  const GetBedroomByIdUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [id] - The bedroom ID to fetch.
  Future<Either<Failure, Bedroom>> call(String id) async {
    return repository.getBedroomById(id);
  }
}

/// Use case for getting bedrooms by category.
class GetBedroomsByCategoryUseCase {
  final BedroomRepository repository;

  const GetBedroomsByCategoryUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [category] - The category to filter by.
  Future<Either<Failure, List<Bedroom>>> call(String category) async {
    return repository.getBedroomsByCategory(category);
  }
}

/// Use case for getting featured bedrooms.
class GetFeaturedBedroomsUseCase {
  final BedroomRepository repository;

  const GetFeaturedBedroomsUseCase(this.repository);

  /// Execute the use case.
  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getFeaturedBedrooms();
  }
}

/// Use case for searching bedrooms.
class SearchBedroomsUseCase {
  final BedroomRepository repository;

  const SearchBedroomsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [query] - Search query string.
  Future<Either<Failure, List<Bedroom>>> call(String query) async {
    return repository.searchBedrooms(query);
  }
}
