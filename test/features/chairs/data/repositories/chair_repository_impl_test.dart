import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furnishop/core/errors/exceptions.dart';
import 'package:furnishop/core/errors/failures.dart';
import 'package:furnishop/features/chairs/data/datasources/chair_datasource.dart';
import 'package:furnishop/features/chairs/data/models/chair_model.dart';
import 'package:furnishop/features/chairs/data/repositories/chair_repository_impl.dart';
import 'package:furnishop/features/chairs/domain/entities/chair_entity.dart';
import 'package:mocktail/mocktail.dart';

// Mock data source
class MockChairDataSource extends Mock implements ChairDataSource {}

void main() {
  late MockChairDataSource mockDataSource;
  late ChairRepositoryImpl repository;

  // Test data
  const testChairModel = ChairModel(
    id: 'test-001',
    name: 'Test Chair',
    description: 'A test chair',
    price: 199.99,
    originalPrice: 249.99,
    imageUrl: 'https://example.com/chair.jpg',
    rating: 4.5,
    reviewCount: 100,
    inStock: true,
    category: 'office',
    material: 'mesh',
    color: 'black',
    dimensions: ChairDimensionsModel(
      width: 60,
      height: 120,
      depth: 55,
      weight: 15,
    ),
    isFeatured: true,
    tags: ['ergonomic', 'office'],
  );

  final testChairModelsList = [testChairModel];

  setUp(() {
    mockDataSource = MockChairDataSource();
    repository = ChairRepositoryImpl(dataSource: mockDataSource);
  });

  group('getChairs', () {
    test('should return list of chairs when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenAnswer((_) async => testChairModelsList);

      // Act
      final result = await repository.getChairs();

      // Assert
      expect(result, isA<Right<Failure, List<Chair>>>());
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (chairs) {
          expect(chairs.length, 1);
          expect(chairs.first.id, 'test-001');
        },
      );
      verify(() => mockDataSource.getChairs()).called(1);
    });

    test('should return ServerFailure when data source throws ServerException',
        () async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenThrow(const ServerException(message: 'Server error'));

      // Act
      final result = await repository.getChairs();

      // Assert
      expect(result, isA<Left<Failure, List<Chair>>>());
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server error');
        },
        (chairs) => fail('Expected Left but got Right'),
      );
    });

    test(
        'should return NetworkFailure when data source throws NetworkException',
        () async {
      // Arrange
      when(() => mockDataSource.getChairs())
          .thenThrow(const NetworkException(message: 'No internet'));

      // Act
      final result = await repository.getChairs();

      // Assert
      expect(result, isA<Left<Failure, List<Chair>>>());
      result.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'No internet');
        },
        (chairs) => fail('Expected Left but got Right'),
      );
    });

    test('should return UnexpectedFailure when data source throws Exception',
        () async {
      // Arrange
      when(() => mockDataSource.getChairs()).thenThrow(Exception('Unknown'));

      // Act
      final result = await repository.getChairs();

      // Assert
      expect(result, isA<Left<Failure, List<Chair>>>());
      result.fold(
        (failure) {
          expect(failure, isA<UnexpectedFailure>());
        },
        (chairs) => fail('Expected Left but got Right'),
      );
    });
  });

  group('getChairById', () {
    test('should return chair when data source call is successful', () async {
      // Arrange
      when(() => mockDataSource.getChairById('test-001'))
          .thenAnswer((_) async => testChairModel);

      // Act
      final result = await repository.getChairById('test-001');

      // Assert
      expect(result, isA<Right<Failure, Chair>>());
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (chair) {
          expect(chair.id, 'test-001');
          expect(chair.name, 'Test Chair');
        },
      );
      verify(() => mockDataSource.getChairById('test-001')).called(1);
    });

    test(
        'should return NotFoundFailure when data source throws NotFoundException',
        () async {
      // Arrange
      when(() => mockDataSource.getChairById('invalid'))
          .thenThrow(const NotFoundException(message: 'Chair not found'));

      // Act
      final result = await repository.getChairById('invalid');

      // Assert
      expect(result, isA<Left<Failure, Chair>>());
      result.fold(
        (failure) {
          expect(failure, isA<NotFoundFailure>());
          expect(failure.message, 'Chair not found');
        },
        (chair) => fail('Expected Left but got Right'),
      );
    });
  });

  group('getChairsByCategory', () {
    test('should return chairs by category when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.getChairsByCategory('office'))
          .thenAnswer((_) async => testChairModelsList);

      // Act
      final result = await repository.getChairsByCategory('office');

      // Assert
      expect(result, isA<Right<Failure, List<Chair>>>());
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (chairs) {
          expect(chairs.length, 1);
          expect(chairs.first.category, 'office');
        },
      );
    });
  });

  group('getFeaturedChairs', () {
    test('should return featured chairs when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.getFeaturedChairs())
          .thenAnswer((_) async => testChairModelsList);

      // Act
      final result = await repository.getFeaturedChairs();

      // Assert
      expect(result, isA<Right<Failure, List<Chair>>>());
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (chairs) {
          expect(chairs.length, 1);
          expect(chairs.first.isFeatured, true);
        },
      );
    });
  });

  group('searchChairs', () {
    test('should return matching chairs when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.searchChairs('ergonomic'))
          .thenAnswer((_) async => testChairModelsList);

      // Act
      final result = await repository.searchChairs('ergonomic');

      // Assert
      expect(result, isA<Right<Failure, List<Chair>>>());
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (chairs) {
          expect(chairs.length, 1);
        },
      );
    });
  });
}
