import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chair_entity.dart';
import '../repositories/chair_repository.dart';

/// Use case for getting all chairs.
///
/// This follows the Clean Architecture use case pattern.
/// It encapsulates a single business action.
class GetChairsUseCase {
  final ChairRepository repository;

  const GetChairsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// Returns [Right] with list of chairs on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Chair>>> call() async {
    return repository.getChairs();
  }
}

/// Use case for getting a single chair by ID.
class GetChairByIdUseCase {
  final ChairRepository repository;

  const GetChairByIdUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [id] - The chair ID to fetch.
  Future<Either<Failure, Chair>> call(String id) async {
    return repository.getChairById(id);
  }
}

/// Use case for getting chairs by category.
class GetChairsByCategoryUseCase {
  final ChairRepository repository;

  const GetChairsByCategoryUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [category] - The category to filter by.
  Future<Either<Failure, List<Chair>>> call(String category) async {
    return repository.getChairsByCategory(category);
  }
}

/// Use case for getting featured chairs.
class GetFeaturedChairsUseCase {
  final ChairRepository repository;

  const GetFeaturedChairsUseCase(this.repository);

  /// Execute the use case.
  Future<Either<Failure, List<Chair>>> call() async {
    return repository.getFeaturedChairs();
  }
}

/// Use case for searching chairs.
class SearchChairsUseCase {
  final ChairRepository repository;

  const SearchChairsUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [query] - Search query string.
  Future<Either<Failure, List<Chair>>> call(String query) async {
    return repository.searchChairs(query);
  }
}
