import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/bedroom_entity.dart';
import '../repositories/bedroom_repository.dart';

/// Use case for retrieving all bedrooms.
class GetBedroomsUseCase {
  final BedroomRepository repository;

  const GetBedroomsUseCase(this.repository);

  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getBedrooms();
  }
}

/// Use case for fetching a bedroom by ID.
class GetBedroomByIdUseCase {
  final BedroomRepository repository;

  const GetBedroomByIdUseCase(this.repository);

  Future<Either<Failure, Bedroom>> call(String id) async {
    return repository.getBedroomById(id);
  }
}

/// Use case for filtering bedrooms by category.
class GetBedroomsByCategoryUseCase {
  final BedroomRepository repository;

  const GetBedroomsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<Bedroom>>> call(String category) async {
    return repository.getBedroomsByCategory(category);
  }
}

/// Use case for retrieving featured bedrooms.
class GetFeaturedBedroomsUseCase {
  final BedroomRepository repository;

  const GetFeaturedBedroomsUseCase(this.repository);

  Future<Either<Failure, List<Bedroom>>> call() async {
    return repository.getFeaturedBedrooms();
  }
}

/// Use case for searching bedrooms.
class SearchBedroomsUseCase {
  final BedroomRepository repository;

  const SearchBedroomsUseCase(this.repository);

  Future<Either<Failure, List<Bedroom>>> call(String query) async {
    return repository.searchBedrooms(query);
  }
}
