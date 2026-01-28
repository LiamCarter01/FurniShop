import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/desk_entity.dart';
import '../../domain/repositories/desk_repository.dart';
import '../datasources/desk_datasource.dart';

/// Implementation of [DeskRepository].
///
/// Connects domain layer to data layer, mapping exceptions to failures.
class DeskRepositoryImpl implements DeskRepository {
  final DeskDataSource dataSource;

  const DeskRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Desk>>> getDesks() async {
    try {
      final desks = await dataSource.getDesks();
      return Right(desks);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Desk>> getDeskById(String id) async {
    try {
      final desk = await dataSource.getDeskById(id);
      return Right(desk);
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
  Future<Either<Failure, List<Desk>>> getDesksByCategory(String category) async {
    try {
      final desks = await dataSource.getDesksByCategory(category);
      return Right(desks);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Desk>>> getFeaturedDesks() async {
    try {
      final desks = await dataSource.getFeaturedDesks();
      return Right(desks);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Desk>>> searchDesks(String query) async {
    try {
      final desks = await dataSource.searchDesks(query);
      return Right(desks);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
