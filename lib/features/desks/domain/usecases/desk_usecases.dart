import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/desk_entity.dart';
import '../repositories/desk_repository.dart';

/// Use case for getting all desks.
///
/// It encapsulates a single business action.
class GetDesksUseCase {
  final DeskRepository repository;

  const GetDesksUseCase(this.repository);

  /// Execute the use case.
  ///
  /// Returns [Right] with list of desks on success.
  /// Returns [Left] with [Failure] on error.
  Future<Either<Failure, List<Desk>>> call() async {
    return repository.getDesks();
  }
}

/// Use case for getting a single desk by ID.
class GetDeskByIdUseCase {
  final DeskRepository repository;

  const GetDeskByIdUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [id] - The desk ID to fetch.
  Future<Either<Failure, Desk>> call(String id) async {
    return repository.getDeskById(id);
  }
}

/// Use case for getting desks by category.
class GetDesksByCategoryUseCase {
  final DeskRepository repository;

  const GetDesksByCategoryUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [category] - The category to filter by.
  Future<Either<Failure, List<Desk>>> call(String category) async {
    return repository.getDesksByCategory(category);
  }
}

/// Use case for getting featured desks.
class GetFeaturedDesksUseCase {
  final DeskRepository repository;

  const GetFeaturedDesksUseCase(this.repository);

  /// Execute the use case.
  Future<Either<Failure, List<Desk>>> call() async {
    return repository.getFeaturedDesks();
  }
}

/// Use case for searching desks.
class SearchDesksUseCase {
  final DeskRepository repository;

  const SearchDesksUseCase(this.repository);

  /// Execute the use case.
  ///
  /// [query] - Search query string.
  Future<Either<Failure, List<Desk>>> call(String query) async {
    return repository.searchDesks(query);
  }
}
