import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/living_room_entity.dart';
import '../../domain/repositories/living_room_repository.dart';
import '../datasources/living_room_datasource.dart';

/// Implementation of [LivingRoomRepository].
///
/// Connects the domain layer to the data layer and maps exceptions to failures.
class LivingRoomRepositoryImpl implements LivingRoomRepository {
  final LivingRoomDataSource dataSource;

  const LivingRoomRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<LivingRoom>>> getLivingRooms() async {
    try {
      final rooms = await dataSource.getLivingRooms();
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LivingRoom>> getLivingRoomById(String id) async {
    try {
      final room = await dataSource.getLivingRoomById(id);
      return Right(room);
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
  Future<Either<Failure, List<LivingRoom>>> getLivingRoomsByCategory(String category) async {
    try {
      final rooms = await dataSource.getLivingRoomsByCategory(category);
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LivingRoom>>> getFeaturedLivingRooms() async {
    try {
      final rooms = await dataSource.getFeaturedLivingRooms();
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LivingRoom>>> searchLivingRooms(String query) async {
    try {
      final rooms = await dataSource.searchLivingRooms(query);
      return Right(rooms);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}