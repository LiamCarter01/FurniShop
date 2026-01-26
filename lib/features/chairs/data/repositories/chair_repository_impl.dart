import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chair_entity.dart';
import '../../domain/repositories/chair_repository.dart';
import '../datasources/chair_datasource.dart';

/// Implementation of [ChairRepository].
///
/// This connects the domain layer to the data layer.
/// Handles error mapping from exceptions to failures.
class ChairRepositoryImpl implements ChairRepository {
  final ChairDataSource dataSource;

  const ChairRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Chair>>> getChairs() async {
    try {
      final chairs = await dataSource.getChairs();
      return Right(chairs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Chair>> getChairById(String id) async {
    try {
      final chair = await dataSource.getChairById(id);
      return Right(chair);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message, code: e.code));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Chair>>> getChairsByCategory(
      String category) async {
    try {
      final chairs = await dataSource.getChairsByCategory(category);
      return Right(chairs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Chair>>> getFeaturedChairs() async {
    try {
      final chairs = await dataSource.getFeaturedChairs();
      return Right(chairs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Chair>>> searchChairs(String query) async {
    try {
      final chairs = await dataSource.searchChairs(query);
      return Right(chairs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
