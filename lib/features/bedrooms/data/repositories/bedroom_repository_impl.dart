import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/bedroom_entity.dart';
import '../../domain/repositories/bedroom_repository.dart';
import '../datasources/bedroom_datasource.dart';

/// Implementation of [BedroomRepository].
///
/// Bridges the domain and data layers while mapping exceptions to failures.
class BedroomRepositoryImpl implements BedroomRepository {
  final BedroomDataSource dataSource;

  const BedroomRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Bedroom>>> getBedrooms() async {
    try {
      final bedrooms = await dataSource.getBedrooms();
      return Right(bedrooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Bedroom>> getBedroomById(String id) async {
    try {
      final bedroom = await dataSource.getBedroomById(id);
      return Right(bedroom);
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
  Future<Either<Failure, List<Bedroom>>> getBedroomsByCategory(
      String category) async {
    try {
      final bedrooms = await dataSource.getBedroomsByCategory(category);
      return Right(bedrooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bedroom>>> getFeaturedBedrooms() async {
    try {
      final bedrooms = await dataSource.getFeaturedBedrooms();
      return Right(bedrooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Bedroom>>> searchBedrooms(String query) async {
    try {
      final bedrooms = await dataSource.searchBedrooms(query);
      return Right(bedrooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
